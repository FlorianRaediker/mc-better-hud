#> bingo:init/init
#
# This function is called whenever the datapack is reloaded.
#
# It contains all required declaration and initializes some required values if
# this is the first time this datapack is loaded.
#
# It also contains all Data-Pack Helper Plus' style declarations that are at
# least of visibility @internal.
#
# @within tag/function minecraft:load
# @handles #minecraft:load

setworldspawn 1 0 1
forceload add 0 0

#TODO change to use tmp.bingo:<name> everywhere
#declare storage bingo:tmp

#region Storage declarations
	#>
	#
	# @api
	#declare storage bingo:custom_hud

	#>
	# This is the registry used to register things to Minecraft Bingo.
	#
	# To register new things in an extension pack, add your own function to the
	# function tag #bingo:fill_registries.
	#
	# To execute an action before the registries are processed but after all active
	# extension packs have registered everything, add a function to the function tag
	# #bingo:post_registration
	#
	# All registries are an array of the type of thing you want to register.
	#
	# Available registries:
	# categories: categories of Minecraft Bingo. NBT-Structure see storage
	# 	 definition of bingo:items
	# items: All items that are available. NBT-Structure see storage definition of
	# 	bingo:items
	# structures: Each entry holds a string representing a namespaced id of a
	# 	structure file to be added to the lobby. The center must be the corridor.
	# 	Add emptiness in case of unsymetric sizes.
	#
	# In order to modify existing items, either added by the default bingo datapack,
	# or added by another extension pack, please use a function registered to the
	# function tag #bingo:post_register_items
	#
	# The items array should be considered read-only from other places.
	#
	# @api
	#declare storage bingo:registries
#endregion

#region tag declarations
	#>
	# This tag marks a player who is at a location eligible for emerald generation.
	#
	# @internal
	#declare tag bingo.emerald
	#>
	# This tag is given to players whose position changed compared to last tick
	# @internal
	#declare tag bingo.position_changed
	#>
	# This tag is given to players who are currently verifying their resource pack
	#
	# @internal
	#declare tag bingo.resourcepack_check
#endregion

#region setup objectives
	scoreboard objectives remove bingo.const
	scoreboard objectives remove bingo.hud_update
	scoreboard objectives remove bingo.io
	scoreboard objectives remove bingo.menu_page
	scoreboard objectives remove bingo.pos_hash
	scoreboard objectives remove bingo.pref
	scoreboard objectives remove bingo.resources
	scoreboard objectives remove bingo.tmp

	#region public objectives
		#>
		# This objective is used to store constants.
		#
		# Sometimes in Minecraft Commands, it is impossible to do a certain operation
		# without using a scoreboard objective and player name.
		#
		# This objective is used to store any constant that is needed for such an
		# operation
		#
		# @public
		scoreboard objectives add bingo.const dummy

		#>
		# This objective is used for public function's input and output
		#
		# @api
		scoreboard objectives add bingo.io dummy

		#>
		# This objective holds the game state, such as whether a game is currently
		# running
		#
		# @public
		scoreboard objectives add bingo.state dummy

		#>
		# Whether this player's hud needs to be forcefully updated entirely
		# This is for example set when the player changes hud preferences. 
		#
		# @api
		scoreboard objectives add bingo.update_hud dummy
		scoreboard players set @a bingo.update_hud 1
	#endregion

	#region trigger objectives
		#>
		# Trigger objective used to handle changes / clicks in the preferences menu.
		#
		# @internal
		scoreboard objectives add bingo.pref trigger

		#>
		# This trigger is used for confirming that the resource pack is active
		#
		# @internal
		scoreboard objectives add bingo.resources trigger

		#>
		# Trigger objective used to load certain setting pages.
		#
		# @internal
		# @user
		scoreboard objectives add bingo.settings trigger
	#endregion

	#region other internal objectives
		#>
		# This objective contains unique player IDs, used to identify player-specific
		# data in storage.
		#
		# @internal
		scoreboard objectives add bingo.id dummy

		#>
		# This objective stores the page number of a paginated tellraw
		# a player is currently at.
		#
		# This is for example used for the preferences menu. It would otherwise be
		# impossible to display a generated list with clickable items, as the score
		# values that are used for the trigger need to be hardcoded.
		#
		# This scoreboard holds the page the player currently sees.
		#
		# @internal
		scoreboard objectives add bingo.menu_page dummy

		#>
		# This objective is used for temporary calculations.
		#
		# @internal
		scoreboard objectives add bingo.tmp dummy
	#endregion

	#region private objectives
		#>
		# This objective is used to store the player's position hash, which in turn
		# is used to determine whether the player position display needs updating
		# @within
		#		function bingo:init/init
		#		function bingo:tick/player_tick
		scoreboard objectives add bingo.pos_hash dummy

		#>
		# The last time the hud was refreshed for each player
		# #TODO rename to something like "last_hud_update" in 1.18 when the stupid
		# # length limit is gone.
		#
		# @within
		#		function bingo:init/init
		#		function bingo:custom_hud/*
		scoreboard objectives add bingo.hud_update dummy

		#>
		# This objective is used to detect a player reconnecting
		#
		# @within
		#		function bingo:init/init
		#		function bingo:tick/player_tick
		#		function bingo:tick/handle_player_join
		scoreboard objectives add bingo.reconnect minecraft.custom:minecraft.leave_game

	#endregion		

	#region score holders
		#>
		# Whether this is multiplayer
		#
		# @public
		#declare score_holder $is_multiplayer
		scoreboard players add $is_multiplayer bingo.state 0
		#>
		# Time from last tick
		#
		# @internal
		#declare score_holder $last_tick
		scoreboard players reset $last_tick bingo.state
		#>
		# @public
		#declare score_holder -2
		scoreboard players set -2 bingo.const -2
		#>
		# @public
		#declare score_holder -1
		scoreboard players set -1 bingo.const -1
		#>
		# @public
		#declare score_holder 2
		scoreboard players set 2 bingo.const 2
		#>
		# @public
		#declare score_holder 3
		scoreboard players set 3 bingo.const 3
		#>
		# @public
		#declare score_holder 4
		scoreboard players set 4 bingo.const 4
		#>
		# @public
		#declare score_holder 5
		scoreboard players set 5 bingo.const 5
		#>
		# @public
		#declare score_holder 6
		scoreboard players set 6 bingo.const 6
		#>
		# @public
		#declare score_holder 9
		scoreboard players set 9 bingo.const 9
		#>
		# @public
		#declare score_holder 10
		scoreboard players set 10 bingo.const 10
		#>
		# @public
		#declare score_holder 16
		scoreboard players set 16 bingo.const 16
		#>
		# @public
		#declare score_holder 32
		scoreboard players set 32 bingo.const 32
		#>
		# @public
		#declare score_holder 41
		scoreboard players set 41 bingo.const 41
		#>
		# @public
		#declare score_holder 50
		scoreboard players set 50 bingo.const 50
		#>
		# @public
		#declare score_holder 96
		scoreboard players set 96 bingo.const 96
		#>
		# @public
		#declare score_holder 100
		scoreboard players set 100 bingo.const 100
		#>
		# @public
		#declare score_holder 128
		scoreboard players set 128 bingo.const 128
		#>
		# @public
		#declare score_holder 256
		scoreboard players set 256 bingo.const 256
		#>
		# @public
		#declare score_holder 1000
		scoreboard players set 1000 bingo.const 1000
		#>
		# @public
		#declare score_holder 65536
		scoreboard players set 65536 bingo.const 65536
	#endregion
#endregion

# Init slow loops
	schedule function bingo:tick/clean_up 1s replace

#region run registries
	data remove storage bingo:registries hud_components
	data remove storage bingo:registries preferences
	function #bingo:fill_registries

	#TODO probably should make a new tag for sanity checking and post-processing
	# here which is called after fill_registries and post_generation.
	#
	# This way we make sure, post_generation only sees valid entries.
	# This would mean moving some logic around for vanilla stuff.
	#
	# The result should be that all registry's entries are in a state they would be
	# after the init function has run through completely, apart from fields that
	# depend on other registries (e.g. the category's items or totalItemWeight
	# fields would not be included.)

	#>
	# Function tag for doing actions after the item registration, but before the
	# items are duplicated into the categories array.
	#
	# You may use this function tag for modifing existing items from the default
	# bingo item pool or from other extension packs.
	#
	# @api
	#declare tag/function bingo:post_registration
	function #bingo:post_registration
#endregion

#region initialize hud components
	#>
	# @within
	# 	function bingo:init/init
	# 	function bingo:init/initialize_hud_components/*
	#declare storage tmp.bingo:init/hud
	data modify storage bingo:custom_hud components set value []

	data modify storage tmp.bingo:init/hud columns set value [[], []]
	data modify storage tmp.bingo:init/hud whereSpace set value []
	data modify storage tmp.bingo:init/hud unpreferred set value []
	data modify storage tmp.bingo:init/hud dontAdd set value []
	function bingo:init/initialize_hud_components/add_defaults
	data modify storage tmp.bingo:init/hud whereSpace append from storage tmp.bingo:init/hud unpreferred[]

	data modify storage bingo:custom_hud components set value []
	data modify storage bingo:custom_hud components append from storage tmp.bingo:init/hud columns[0][]
	data modify storage bingo:custom_hud components append from storage tmp.bingo:init/hud columns[1][]
	data modify storage bingo:custom_hud components append from storage tmp.bingo:init/hud whereSpace[]
	data modify storage bingo:custom_hud components append from storage tmp.bingo:init/hud dontAdd[]

	data modify storage bingo:custom_hud default set value []
	data modify storage bingo:custom_hud default append from storage tmp.bingo:init/hud columns[0][0]
	data modify storage bingo:custom_hud default append from storage tmp.bingo:init/hud columns[0][1]
	data modify storage bingo:custom_hud default append from storage tmp.bingo:init/hud columns[0][2]
	data modify storage bingo:custom_hud default append from storage tmp.bingo:init/hud columns[0][3]
	data modify storage bingo:custom_hud default append from storage tmp.bingo:init/hud columns[0][4]
	execute unless data storage bingo:custom_hud default[4] run function bingo:init/initialize_hud_components/fill_default_col0
	
	execute unless data storage tmp.bingo:init/hud columns[1][5] run data modify storage bingo:custom_hud default append value {id: "bingo:spacer", name: '{"translate": "bingo.custom_hud.components.spacer"}', padding: '{"translate": "space.91"}', slot_id: 5b}
	data modify storage bingo:custom_hud default append from storage tmp.bingo:init/hud columns[1][0]
	data modify storage bingo:custom_hud default append from storage tmp.bingo:init/hud columns[1][1]
	data modify storage bingo:custom_hud default append from storage tmp.bingo:init/hud columns[1][2]
	data modify storage bingo:custom_hud default append from storage tmp.bingo:init/hud columns[1][3]
	data modify storage bingo:custom_hud default append from storage tmp.bingo:init/hud columns[1][4]
	data modify storage bingo:custom_hud default append from storage tmp.bingo:init/hud columns[1][5]
	execute unless data storage bingo:custom_hud default[10] run function bingo:init/initialize_hud_components/fill_default_col1
	
	data remove storage bingo:custom_hud default[].addByDefault
	data remove storage bingo:custom_hud default[].preferredColumn
#endregion
