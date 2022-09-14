import glob
import json
import os
import re
import shutil
import urllib.request
from typing import Iterable


def copy_files(src_files: Iterable[str], dest: str):
    for filepath in src_files:
        if ":" in filepath:
            src_file, dest_file = filepath.split(":")
        else:
            src_file = dest_file = filepath
        if os.path.isfile(src_file):
            file_dest = os.path.join(dest, dest_file)
            os.makedirs(os.path.dirname(file_dest), exist_ok=True)

            if src_file.endswith(".mcfunction"):
                with open(src_file, "r") as f:
                    content = minify_function_file(f.read())
                with open(file_dest, "w") as f:
                    f.write(content)
            else:
                shutil.copy2(src_file, file_dest)


def minify_function_file(file_content: str):
	output=""
	remove=0
	uncomment=0

	for line in file_content.splitlines():
		line = line.strip()

		if line.startswith("#") and uncomment != 0:
			line = line[1:]
			uncomment -= 1
		elif uncomment < 0:
			uncomment = 0

		if remove > 0:
			remove -= 1
		elif not line.startswith("#") and line:
			if output:
				output += "\n"
			output += line
		elif line.startswith("#NEUN_SCRIPT"):
			match=re.match("#NEUN_SCRIPT\s+(.*)", line)

			if match != None:
				command = re.sub("\s+", " ", match.group(1)).lower().split(" ")

				if command[0] == "uncomment":
					uncomment = -1
					if len(command) > 1:
						try:
							uncomment = int(command[1])
						except ValueError:
							pass

				if command[0] == "remove":
					remove = 1
					if len(command) > 1:
						try:
							remove = int(command[1])
						except ValueError:
							pass
	return output


with open("build.config.json", "r") as f:
    config = json.load(f)

target = config["target"]
if os.path.exists(target):
    shutil.rmtree(target)

base_tmp_dir = os.path.join(target, "tmp")


for pack in config["packs"]:
    pack_name = pack["name"].format(version=config["version"])

    tmp_dir = os.path.join(base_tmp_dir, pack_name)
    os.makedirs(tmp_dir, exist_ok=True)

    for dep in pack.get("dependencies", []):
        dep_file = os.path.join(tmp_dir, "_dependency.zip")
        urllib.request.urlretrieve(dep["url"], dep_file)
        shutil.unpack_archive(dep_file, tmp_dir)
        os.remove(dep_file)
        for exclude in dep.get("exclude", []):
            os.remove(os.path.join(tmp_dir, exclude))
        for move_src, move_dest in dep.get("move", {}).items():
            shutil.move(os.path.join(tmp_dir, move_src), os.path.join(tmp_dir, move_dest))
    
    exclude_files = [file for pattern in pack.get("exclude", []) for file in glob.glob(pattern, recursive=True)]
    files = []
    for pattern in pack["include"]:
        if ":" in pattern:
            files.append(pattern)
        else:
            for file in glob.glob(pattern, recursive=True):
                if file not in exclude_files:
                    files.append(file)
    copy_files(files, tmp_dir)

    archive_name, archive_format = pack_name.rsplit(".", 1)
    shutil.make_archive(os.path.join(target, archive_name), archive_format, tmp_dir)


shutil.rmtree(base_tmp_dir)
