GLOBAL_LIST_EMPTY(preferences_datums)

GLOBAL_LIST_EMPTY(chosen_names)

/datum/preferences
	var/client/parent
	//doohickeys for savefiles
	var/path
	var/default_slot = 1				//Holder so it doesn't default to slot 1, rather the last one used
	var/max_save_slots = 60

	//non-preference stuff
	var/muted = 0
	var/last_ip
	var/last_id

	//game-preferences
	var/lastchangelog = ""				//Saved changlog filesize to detect if there was a change
	var/ooccolor = "#c43b23"
	var/asaycolor = "#ff4500"			//This won't change the color for current admins, only incoming ones.
	var/triumphs = 0
	var/enable_tips = TRUE
	var/tip_delay = 500 //tip delay in milliseconds
	// Commend variable on prefs instead of client to prevent reconnect abuse (is persistant on prefs, opposed to not on client)
	var/commendedsomeone = FALSE

	//Antag preferences
	var/list/be_special = list()		//Special role selection
	var/tmp/old_be_special = 0			//Bitflag version of be_special, used to update old savefiles and nothing more
										//If it's 0, that's good, if it's anything but 0, the owner of this prefs file's antag choices were,
										//autocorrected this round, not that you'd need to check that.

	var/UI_style = null
	var/buttons_locked = TRUE
	var/hotkeys = TRUE

	var/chat_on_map = TRUE
	var/showrolls = TRUE
	var/max_chat_length = CHAT_MESSAGE_MAX_LENGTH
	var/see_chat_non_mob = TRUE

	// Custom Keybindings
	var/list/key_bindings = list()

	var/tgui_fancy = TRUE
	var/tgui_lock = TRUE
	var/tgui_theme = "azure_default"
	var/windowflashing = TRUE
	var/toggles = TOGGLES_DEFAULT
	var/floating_text_toggles = TOGGLES_TEXT_DEFAULT
	var/admin_chat_toggles = TOGGLES_DEFAULT_CHAT_ADMIN
	var/db_flags
	var/chat_toggles = TOGGLES_DEFAULT_CHAT
	var/ghost_form = "ghost"
	var/ghost_orbit = GHOST_ORBIT_CIRCLE
	var/ghost_accs = GHOST_ACCS_DEFAULT_OPTION
	var/ghost_others = GHOST_OTHERS_DEFAULT_OPTION
	var/ghost_hud = 1
	var/inquisitive_ghost = 1
	var/allow_midround_antag = 1
	var/preferred_map = null
	var/pda_style = MONO
	var/pda_color = "#808000"

	var/uses_glasses_colour = 0

	//character preferences
	var/slot_randomized					//keeps track of round-to-round randomization of the character slot, prevents overwriting
	var/real_name						//our character's name
	var/gender = MALE					//gender of character (well duh) (LETHALSTONE EDIT: this no longer references anything but whether the masculine or feminine model is used)
	var/pronouns = HE_HIM				// LETHALSTONE EDIT: character's pronouns (well duh)
	var/voice_type = VOICE_TYPE_MASC	// LETHALSTONE EDIT: the type of soundpack the mob should use
	var/datum/statpack/statpack	= new /datum/statpack/wildcard/fated // LETHALSTONE EDIT: the statpack we're giving our char instead of racial bonuses
	var/datum/virtue/virtue = new /datum/virtue/none // LETHALSTONE EDIT: the virtue we get for not picking a statpack
	var/datum/virtue/virtuetwo = new /datum/virtue/none
	var/age = AGE_ADULT						//age of character
	var/origin = "Default"
	var/accessory = "Nothing"
	var/detail = "Nothing"
	var/backpack = DBACKPACK				//backpack type
	var/jumpsuit_style = PREF_SUIT		//suit/skirt
	var/hairstyle = "Bald"				//Hair type
	var/hair_color = "000"				//Hair color
	var/facial_hairstyle = "Shaved"	//Face hair type
	var/facial_hair_color = "000"		//Facial hair color
	var/skin_tone = "caucasian1"		//Skin color
	var/eye_color = "000"				//Eye color
	var/extra_language = "None" // Extra language
	var/voice_color = "a0a0a0"
	var/voice_pitch = 1
	var/detail_color = "000"
	var/datum/species/pref_species = new /datum/species/human/northern()	//Mutant race
	var/static/datum/species/default_species = new /datum/species/human/northern()
	var/datum/patron/selected_patron
	var/static/datum/patron/default_patron = /datum/patron/divine/undivided
	var/list/features = MANDATORY_FEATURE_LIST
	var/list/randomise = list(RANDOM_UNDERWEAR = TRUE, RANDOM_UNDERWEAR_COLOR = TRUE, RANDOM_UNDERSHIRT = TRUE, RANDOM_SOCKS = TRUE, RANDOM_BACKPACK = TRUE, RANDOM_JUMPSUIT_STYLE = FALSE, RANDOM_SKIN_TONE = TRUE, RANDOM_EYE_COLOR = TRUE)
	var/list/friendlyGenders = list("male" = "мужское", "female" = "женское")
	var/phobia = "spiders"
	var/shake = TRUE
	var/sexable = FALSE
	var/compliance_notifs = TRUE

	var/list/custom_names = list()
	var/preferred_ai_core_display = "Blue"
	var/prefered_security_department = SEC_DEPT_RANDOM

	//Quirk list
	var/list/all_quirks = list()

	//Job preferences 2.0 - indexed by job title , no key or value implies never
	var/list/job_preferences = list()

		// Want randomjob if preferences already filled - Donkie
	var/joblessrole = RETURNTOLOBBY  //defaults to 1 for fewer assistants

	// 0 = character settings, 1 = game preferences
	var/current_tab = 0

	var/unlock_content = 0

	var/list/ignoring = list()

	var/clientfps = 100//0 is sync

	var/parallax

	var/ambientocclusion = TRUE
	var/auto_fit_viewport = FALSE
	var/widescreenpref = TRUE

	var/musicvol = 50
	var/mastervol = 50

	var/anonymize = TRUE
	var/masked_examine = FALSE
	var/mute_animal_emotes = FALSE
	var/autoconsume = FALSE
	var/no_examine_blocks = FALSE

	var/lastclass

	var/uplink_spawn_loc = UPLINK_PDA

	var/list/exp = list()
	var/list/menuoptions

	var/datum/migrant_pref/migrant
	var/next_special_trait = null

	var/action_buttons_screen_locs = list()

	var/domhand = 2
	var/nickname = "Пожалуйста смени меня"
	var/highlight_color = "#FF0000"
	var/datum/charflaw/charflaw

	var/static/default_cmusic_type = /datum/combat_music/default
	var/datum/combat_music/combat_music
	var/combat_music_helptext_shown = FALSE

	var/family = FAMILY_NONE

	var/crt = FALSE
	var/grain = TRUE
	var/dnr_pref = FALSE

	var/list/customizer_entries = list()
	var/list/list/body_markings = list()
	var/update_mutant_colors = TRUE

	var/headshot_link
	var/chatheadshot = FALSE
	var/ooc_extra
	var/song_artist
	var/song_title
	var/list/descriptor_entries = list()
	var/list/custom_descriptors = list()

	var/char_accent = "No accent"

	var/datum/loadout_item/loadout
	var/datum/loadout_item/loadout2
	var/datum/loadout_item/loadout3

	var/flavortext

	var/ooc_notes

	var/nsfwflavortext

	var/erpprefs

	var/list/img_gallery = list()

	var/datum/familiar_prefs/familiar_prefs

	var/taur_type = null
	var/taur_color = "ffffff"

	/// Assoc list of culinary preferences, where the key is the type of the culinary preference, and value is food/drink typepath
	var/list/culinary_preferences = list()

	var/datum/advclass/preview_subclass

	var/tgui_pref = TRUE

	var/race_bonus

/datum/preferences/New(client/C)
	parent = C
	migrant  = new /datum/migrant_pref(src)
	familiar_prefs = new /datum/familiar_prefs(src)

	for(var/custom_name_id in GLOB.preferences_custom_names)
		custom_names[custom_name_id] = get_default_name(custom_name_id)

	UI_style = GLOB.available_ui_styles[1]
	if(istype(C))
		if(!IsGuestKey(C.key))
			load_path(C.ckey)
			unlock_content = C.IsByondMember()
			if(unlock_content)
				max_save_slots = 100
	var/loaded_preferences_successfully = load_preferences()
	if(loaded_preferences_successfully)
		if(load_character())
			if(check_nameban(C.ckey) || (C.blacklisted() == 1))
				real_name = pref_species.random_name(gender,1)
			return
	//Set the race to properly run race setter logic
	set_new_race(pref_species, null)
	if(!charflaw)
		charflaw = pick(GLOB.character_flaws)
		charflaw = GLOB.character_flaws[charflaw]
		charflaw = new charflaw()
	if(!selected_patron)
		selected_patron = GLOB.patronlist[default_patron]
	if(!combat_music)
		combat_music = GLOB.cmode_tracks_by_type[default_cmusic_type]
	key_bindings = deepCopyList(GLOB.hotkey_keybinding_list_by_key) // give them default keybinds and update their movement keys
	C.update_movement_keys()
	if(!loaded_preferences_successfully)
		save_preferences()
	save_character()		//let's save this new random character so it doesn't keep generating new ones.
	menuoptions = list()
	return

/datum/preferences/proc/set_new_race(datum/species/new_race, user)
	pref_species = new_race
	real_name = pref_species.random_name(gender,1)
	ResetJobs()
	if(user)
		if(pref_species.desc)
			to_chat(user, "[pref_species.desc]")
		to_chat(user, "<font color='red'>Классы сброшены.</font>")
	random_character(gender, FALSE, FALSE)
	accessory = "Nothing"

	customizer_entries = list()
	validate_customizer_entries()
	reset_all_customizer_accessory_colors()
	randomize_all_customizer_accessories()
	reset_descriptors()
	taur_type = null

#define APPEARANCE_CATEGORY_COLUMN "<td valign='top' width='14%'>"
#define MAX_MUTANT_ROWS 4

/datum/preferences/proc/ShowChoices(mob/user, tabchoice)
	if(!user || !user.client)
		return
	if(slot_randomized)
		load_character(default_slot) // Reloads the character slot. Prevents random features from overwriting the slot if saved.
		slot_randomized = FALSE
	var/list/dat = list("<center>")
	if(tabchoice)
		current_tab = tabchoice
	if(tabchoice == 4)
		current_tab = 0

//	dat += "<a href='?_src_=prefs;preference=tab;tab=0' [current_tab == 0 ? "class='linkOn'" : ""]>Лист персонажа</a>"
//	dat += "<a href='?_src_=prefs;preference=tab;tab=1' [current_tab == 1 ? "class='linkOn'" : ""]>Настройки игры</a>"
//	dat += "<a href='?_src_=prefs;preference=tab;tab=2' [current_tab == 2 ? "class='linkOn'" : ""]>OOC настройки</a>"
//	dat += "<a href='?_src_=prefs;preference=tab;tab=3' [current_tab == 3 ? "class='linkOn'" : ""]>Горячие клавиши</a>"

	dat += "</center>"

	var/used_title
	switch(current_tab)
		if (0) // Character Settings#
			used_title = "Лист персонажа"

			// Top-level menu table
			dat += "<table style='width: 100%; line-height: 20px;'>"
			// NEXT ROW
			dat += "<tr>"
			dat += "<td style='width:33%;text-align:left'>"
			dat += "<a style='white-space:nowrap;' href='?_src_=prefs;preference=changeslot;'>Сменить персонажа</a>"
			dat += "</td>"

			dat += "<td style='width:33%;text-align:center'>"
			dat += "<a href='?_src_=prefs;preference=job;task=menu'>Выбрать класс</a>"
			dat += "</td>"

			dat += "<td style='width:33%;text-align:right'>"
			dat += "<a href='?_src_=prefs;preference=keybinds;task=menu'>Горячие клавиши</a>"
			dat += "</td>"
			dat += "</tr>"

			// ANOTHA ROW
			dat += "<tr style='padding-top: 0px;padding-bottom:0px'>"
			dat += "<td style='width:33%;text-align:left'>"
			dat += "<a href='?_src_=prefs;preference=tgui_ui_prefs;task=menu'>[tgui_pref ? "Интерфейс TG" : "Традиционный интерфейс"]</a>"
			dat += "<br>"
			dat += "<a href='?_src_=prefs;preference=tgui_theme'>Стиль интерфейса: [get_tgui_theme_display_name()]</a>"
			dat += "</td>"

			dat += "<td style='width:33%;text-align:center'>"
			dat += "<a href='?_src_=prefs;preference=antag;task=menu'>Быть ли злодеем?</a>"
			dat += "</td>"

			dat += "<td style='width:33%;text-align:right'>"
			dat += "</td>"
			dat += "</tr>"

			// ANOTHER ROW HOLY SHIT WE FINALLY A GOD DAMN GRID NOW! WHOA!
			dat += "<tr style='padding-top: 0px;padding-bottom:0px'>"
			dat += "<td style='width:33%; text-align:left'>"
			dat += "<a href='?_src_=prefs;preference=playerquality;task=menu'><b>PQ:</b></a> [get_playerquality(user.ckey, text = TRUE)]"
			dat += "</td>"

			dat += "<td style='width:33%;text-align:center'>"
			dat += "<a href='?_src_=prefs;preference=triumphs;task=menu'><b>ТРИУМФЫ:</b></a> [user.get_triumphs() ? "\Roman [user.get_triumphs()]" : "Нет"]"
			if(SStriumphs.triumph_buys_enabled)
				dat += "<a style='white-space:nowrap;' href='?_src_=prefs;preference=triumph_buy_menu'>Триумфальная лавка</a>"
			dat += "</td>"

			var/agevetted = user.check_agevet()
			dat += "<td style='width:33%;text-align:right'>"
			dat += "<a href='?_src_=prefs;preference=agevet'><b>ВОЗРАСТ ПОДТВЕРЖДЁН:</b></a> [agevetted ? "<font color='#74cde0'>АГА!</font>" : "<font color='#897472'>НЕ-А!</font>"]"
			dat += "</td>"

			dat += "</table>"

			if(CONFIG_GET(flag/roundstart_traits))
				dat += "<center><h2>Настроить особенности</h2>"
				dat += "<a href='?_src_=prefs;preference=trait;task=menu'>Настройка ообенностей</a><br></center>"
				dat += "<center><b>Текущие особенности:</b> [all_quirks.len ? all_quirks.Join(", ") : "Нет"]</center>"

			// Encapsulating table
			dat += "<table width = '100%'>"
			// Only one Row
			dat += "<tr>"
			// Leftmost Column, 40% width
			dat += "<td width=40% valign='top'>"

// 			-----------START OF IDENT TABLE-----------
			dat += "<h2>Идентичность</h2>"
			dat += "<table width='100%'><tr><td width='75%' valign='top'>"
			if(is_banned_from(user.ckey, "Appearance"))
				dat += "<b>Тебе запрещено самостоятельно выбирать имена и облики. Ты можешь продолжать настраивать своих персонажей, но при входе в игру их имя и облик будут выбраны случайным образом.</b><br>"
//			dat += "<a href='?_src_=prefs;preference=toggle_random;random_type=[RANDOM_NAME]'>Всегда случайное имя: [(randomise[RANDOM_NAME]) ? "Да" : "Нет"]</a>"
//			dat += "<a href='?_src_=prefs;preference=toggle_random;random_type=[RANDOM_NAME_ANTAG]'>Будучи антагонистом: [(randomise[RANDOM_NAME_ANTAG]) ? "Да" : "Нет"]</a>"
			dat += "<b>Имя:</b> "
			if(check_nameban(user.ckey))
				dat += "<a href='?_src_=prefs;preference=name;task=input'>NAMEBANNED</a><BR>"
			else
				dat += "<a href='?_src_=prefs;preference=name;task=input'>[real_name]</a> <a href='?_src_=prefs;preference=name;task=random'>\[R\]</a>"
			dat += "<BR>"
			dat += "<b>Прозвище:</b> "
			dat += "<a href='?_src_=prefs;preference=nickname;task=input'>[nickname]</a><BR>"
			// LETHALSTONE EDIT BEGIN: add pronoun prefs
			dat += "<b>Местоимения:</b> <a href='?_src_=prefs;preference=pronouns;task=input'>[pronouns]</a><BR>"
			// LETHALSTONE EDIT END

			dat += "<BR>"
			dat += "<b>Народность:</b> <a href='?_src_=prefs;preference=species;task=input'>[pref_species.name]</a>[spec_check(user) ? "" : " (!)"]<BR>"
			if(length(pref_species.custom_selection))
				var/race_bonus_display
				if(race_bonus)
					for(var/bonus in pref_species.custom_selection)
						if(pref_species.custom_selection[bonus] == race_bonus)
							race_bonus_display = bonus
							break
				dat += "<b>Бонус народа:</b> <a href='?_src_=prefs;preference=race_bonus_select;task=input'>[race_bonus_display ? "[race_bonus_display]" : "Нет"]</a><BR>"
			else
				race_bonus = null

			// LETHALSTONE EDIT BEGIN: add statpack selection
			dat += "<b>Набор атрибутов:</b> <a href='?_src_=prefs;preference=statpack;task=input'>[statpack.name]</a><BR>"
//			dat += "<a href='?_src_=prefs;preference=species;task=random'>Случайный народ</A> "
//			dat += "<a href='?_src_=prefs;preference=toggle_random;random_type=[RANDOM_SPECIES]'>Всегда случайный народ: [(randomise[RANDOM_SPECIES]) ? "Да" : "Нет"]</A><br>"

			if(!(AGENDER in pref_species.species_traits))
				var/dispGender
				if(gender == MALE)
					dispGender = "Мужское" // LETHALSTONE EDIT: repurpose gender as bodytype, display accordingly
				else if(gender == FEMALE)
					dispGender = "Женское" // LETHALSTONE EDIT: repurpose gender as bodytype, display accordingly
				else
					dispGender = "Другое"
				dat += "<b>Телосложение:</b> <a href='?_src_=prefs;preference=gender'>[dispGender]</a><BR>"
				if(randomise[RANDOM_BODY] || randomise[RANDOM_BODY_ANTAG]) //doesn't work unless random body
					dat += "<a href='?_src_=prefs;preference=toggle_random;random_type=[RANDOM_GENDER]'>Всегда случайное телосложение: [(randomise[RANDOM_GENDER]) ? "Да" : "Нет"]</A>"
					dat += "<a href='?_src_=prefs;preference=toggle_random;random_type=[RANDOM_GENDER_ANTAG]'>Будучи антагонистом: [(randomise[RANDOM_GENDER_ANTAG]) ? "Да" : "Нет"]</A>"
			
			if(LAZYLEN(pref_species.allowed_taur_types))
				var/obj/item/bodypart/taur/T = taur_type
				var/name = ispath(T) ? T::name : "Выбрать"
				dat += "<b>Тип звериной части:</b> <a href='?_src_=prefs;preference=taur_type;task=input'>[name]</a><BR>"
				dat += "<b>Цвет звериной части:</b><span style='border: 1px solid #161616; background-color: #[taur_color];'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span> <a href='?_src_=prefs;preference=taur_color;task=input'>Сменить</a><BR>"

			// LETHALSTONE EDIT BEGIN: add voice type prefs
			dat += "<b>Тип голоса</b>: <a href='?_src_=prefs;preference=voicetype;task=input'>[voice_type]</a><BR>"
			// LETHALSTONE EDIT END

			dat += "<b>Возраст:</b> <a href='?_src_=prefs;preference=age;task=input'>[age]</a><BR>"

//			dat += "<br><b>Возраст:</b> <a href='?_src_=prefs;preference=age;task=input'>[age]</a>"
//			if(randomise[RANDOM_BODY] || randomise[RANDOM_BODY_ANTAG]) //doesn't work unless random body
//				dat += "<a href='?_src_=prefs;preference=toggle_random;random_type=[RANDOM_AGE]'>Всегда случайный возраст: [(randomise[RANDOM_AGE]) ? "Да" : "Нет"]</A>"
//				dat += "<a href='?_src_=prefs;preference=toggle_random;random_type=[RANDOM_AGE_ANTAG]'>Будучи антагонистом: [(randomise[RANDOM_AGE_ANTAG]) ? "Да" : "Нет"]</A>"

//			dat += "<b><a href='?_src_=prefs;preference=name;task=random'>Случайное имя</A></b><BR>"
			if(length(pref_species.restricted_virtues))
				if(virtue.type in pref_species.restricted_virtues)
					virtue = GLOB.virtues[/datum/virtue/none]
				if(virtuetwo.type in pref_species.restricted_virtues)
					virtuetwo = GLOB.virtues[/datum/virtue/none]
			dat += "<b>Достоинство:</b> <a href='?_src_=prefs;preference=virtue;task=input'>[virtue]</a><BR>"
			if(statpack.name == "Virtuous")
				dat += "<b>Второе Достоинство:</b> <a href='?_src_=prefs;preference=virtuetwo;task=input'>[virtuetwo]</a><BR>"
			else
				virtuetwo = GLOB.virtues[/datum/virtue/none]
			dat += "<b>Недостаток:</b> <a href='?_src_=prefs;preference=charflaw;task=input'>[charflaw]</a><BR>"
			var/datum/faith/selected_faith = GLOB.faithlist[selected_patron?.associated_faith]
			dat += "<b>Верование:</b> <a href='?_src_=prefs;preference=faith;task=input'>[selected_faith?.name || "FUCK!"]</a><BR>"
			dat += "<b>Покровитель:</b> <a href='?_src_=prefs;preference=patron;task=input'>[selected_patron?.name || "FUCK!"]</a><BR>"
			dat += "<b>Ведущая рука:</b> <a href='?_src_=prefs;preference=domhand'>[domhand == 1 ? "Левая" : "Правая"]</a><BR>"
			dat += "<b>Вкусовые предпочтения:</b> <a href='?_src_=prefs;preference=culinary;task=menu'>Изменить</a><BR>"

			var/musicname = (combat_music.shortname ? combat_music.shortname : combat_music.name)
			dat += "<b>Музыка в бою:</b> <a href='?_src_=prefs;preference=combat_music;task=input'>[musicname || "FUCK!"]</a><BR>"

			dat += "<b>Невоскрешаемый:</b> <a href='?_src_=prefs;preference=dnr;task=input'>[dnr_pref ? "Да" : "Нет"]</a><BR>"

			dat += "<b>Становление фамильяром:</b><a href='?_src_=prefs;preference=familiar_prefs;task=input'>Параметры</a>"
			dat += "<br><b>Цвет имени: </b> </b><a href='?_src_=prefs;preference=highlight_color;task=input'>Изменить</a>"
			dat += "<br><b>Цвет голоса: </b><a href='?_src_=prefs;preference=voice;task=input'>Изменить</a>"
			dat += "<br><b>Высота голоса: </b><a href='?_src_=prefs;preference=voice_pitch;task=input'>[voice_pitch]</a>"

/*
			dat += "<br><br><b>Special Names:</b><BR>"
			var/old_group
			for(var/custom_name_id in GLOB.preferences_custom_names)
				var/namedata = GLOB.preferences_custom_names[custom_name_id]
				if(!old_group)
					old_group = namedata["group"]
				else if(old_group != namedata["group"])
					old_group = namedata["group"]
					dat += "<br>"
				dat += "<a href ='?_src_=prefs;preference=[custom_name_id];task=input'><b>[namedata["pref_name"]]:</b> [custom_names[custom_name_id]]</a> "
			dat += "<br><br>"

			dat += "<b>Custom Job Preferences:</b><BR>"
			dat += "<a href='?_src_=prefs;preference=ai_core_icon;task=input'><b>Preferred AI Core Display:</b> [preferred_ai_core_display]</a><br>"
			dat += "<a href='?_src_=prefs;preference=sec_dept;task=input'><b>Preferred Security Department:</b> [prefered_security_department]</a><BR></td>"
*/
			dat += "</tr></table>"
// 			-----------END OF IDENT TABLE-----------


			// Middle dummy Column, 20% width
			dat += "</td>"
			dat += "<td width=20% valign='top'>"
			var/datum/job/highest_pref
			for(var/job in job_preferences)
				if(job_preferences[job] > highest_pref)
					highest_pref = SSjob.GetJob(job)
			if(!isnull(highest_pref) && !istype(highest_pref, /datum/job/roguetown/jester))
				dat += "<div style='text-align: center'><br>Предпросмотр подкласса:<br> <a href='?_src_=prefs;preference=subclassoutfit;task=input'>[preview_subclass ? "[preview_subclass.name]" : "Никакой"]</a></div>"
			else
				preview_subclass = null
			// Rightmost column, 40% width
			dat += "<td width=40% valign='top'>"
			dat += "<h2>Телесность</h2>"

//			-----------START OF BODY TABLE-----------
			dat += "<table width='100%'><tr><td width='1%' valign='top'>"
			dat += "<b>Применять цвет окраса на черты внешности при его изменении:</b> <a href='?_src_=prefs;preference=update_mutant_colors;task=input'>[update_mutant_colors ? "Да" : "Нет"]</a><BR>"
			var/use_skintones = pref_species.use_skintones
			if(use_skintones)

				var/skin_tone_wording = pref_species.skin_tone_wording // Both the skintone names and the word swap here is useless fluff

				dat += "<b>[skin_tone_wording]: </b><a href='?_src_=prefs;preference=s_tone;task=input'>Change </a>"
				dat += "<br>"

			if((MUTCOLORS in pref_species.species_traits) || (MUTCOLORS_PARTSONLY in pref_species.species_traits))

				dat += "<b>Окрас #1:</b><span style='border: 1px solid #161616; background-color: #[features["mcolor"]];'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span> <a href='?_src_=prefs;preference=mutant_color;task=input'>Изменить</a><BR>"
				dat += "<b>Окрас #2:</b><span style='border: 1px solid #161616; background-color: #[features["mcolor2"]];'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span> <a href='?_src_=prefs;preference=mutant_color2;task=input'>Изменить</a><BR>"
				dat += "<b>Окрас #3:</b><span style='border: 1px solid #161616; background-color: #[features["mcolor3"]];'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span> <a href='?_src_=prefs;preference=mutant_color3;task=input'>Изменить</a><BR>"

			var/datum/language/selected_lang
			var/lang_output = "None"
			if(ispath(extra_language, /datum/language))
				selected_lang = extra_language
				lang_output = initial(selected_lang.name)
			dat += "<b>Дополнительный язык: </b><a href='?_src_=prefs;preference=extra_language;task=input'>[lang_output]</a>"
			var/datum/bark/B = GLOB.bark_list[bark_id] // ! REDMOON
			dat += "<br><b>Звук возгласа: </b><a href='?_src_=prefs;preference=barksound;task=input'>[B ? initial(B.name) : "INVALID"]</a>" // ! REDMOON
			dat += "<br><b>Темп возгласа: </b><a href='?_src_=prefs;preference=barkspeed;task=input'>[bark_speed]</a>" // ! REDMOON
			dat += "<br><b>Высота возгласа: </b><a href='?_src_=prefs;preference=barkpitch;task=input'>[bark_pitch]</a>" // ! REDMOON
			dat += "<br><b>Разброс возгласа: </b><a href='?_src_=prefs;preference=barkvary;task=input'>[bark_variance]</a>" // ! REDMOON
			dat += "<br><a href='?_src_=prefs;preference=barkpreview'>Послушать возгласы</a>" // ! REDMOON

			//dat += "<br><b>Акцент:</b> <a href='?_src_=prefs;preference=char_accent;task=input'>[char_accent]</a>"
			dat += "<br><b>Черты внешности:</b> <a href='?_src_=prefs;preference=customizers;task=menu'>Изменить</a>"
			dat += "<br><b>Размер модельки:</b><a href='?_src_=prefs;preference=body_size;task=input'>[(features["body_size"] * 100)]%</a>"
			dat += "<br><b>Узоры:</b> <a href='?_src_=prefs;preference=markings;task=menu'>Изменить</a>"
			dat += "<br><b>Приметы:</b> <a href='?_src_=prefs;preference=descriptors;task=menu'>Изменить</a>"

			dat += "<br><b>Портрет персонажа:</b> <a href='?_src_=prefs;preference=headshot;task=input'>Изменить</a>"
			if(headshot_link != null)
				dat += "<br><img src='[headshot_link]' width='100px' height='100px'>"

			dat += "<br><b>[(length(flavortext) < MINIMUM_FLAVOR_TEXT) ? "<font color = '#802929'>" : ""]Описание:[(length(flavortext) < MINIMUM_FLAVOR_TEXT) ? "</font>" : ""]</b><a href='?_src_=prefs;preference=formathelp;task=input'>(?)</a><a href='?_src_=prefs;preference=flavortext;task=input'>Изменить</a>"
			dat += "<br><b>Откровенное описание:</b><a href='?_src_=prefs;preference=formathelp;task=input'>(?)</a><a href='?_src_=prefs;preference=nsfwflavortext;task=input'>Изменить</a>"
			dat += "<br><b>[(length(ooc_notes) < MINIMUM_OOC_NOTES) ? "<font color = '#802929'>" : ""]OOC примечания:[(length(ooc_notes) < MINIMUM_OOC_NOTES) ? "</font>" : ""]</b><a href='?_src_=prefs;preference=formathelp;task=input'>(?)</a><a href='?_src_=prefs;preference=ooc_notes;task=input'>Изменить</a>"
			dat += "<br><b>ERP пристрастия:</b><a href='?_src_=prefs;preference=formathelp;task=input'>(?)</a><a href='?_src_=prefs;preference=erpprefs;task=input'>Изменить</a>"
			dat += "<br><b>Песня:</b> <a href='?_src_=prefs;preference=ooc_extra;task=input'>Вставить URL</a>"
			dat += "<a href='?_src_=prefs;preference=change_title;task=input'>Изменить заголовок</a>"
			dat += "<a href='?_src_=prefs;preference=change_artist;task=input'>Изменить автора</a>"
			dat += "<br><B>Галерея изображений:</b> <a href='?_src_=prefs;preference=img_gallery;task=input'>Добавить</a>"
			dat+= "<a href='?_src_=prefs;preference=clear_gallery;task=input'>Очистить галерею</a>"
			dat += "<br><a href='?_src_=prefs;preference=ooc_preview;task=input'><b>Предварительный осмотр</b></a>"

			dat += "<br><b>Персональный предмет I:</b> <a href='?_src_=prefs;preference=loadout_item;task=input'>[loadout ? loadout.name : "Выбрать"]</a>"

			dat += "<br><b>Персональный предмет II:</b> <a href='?_src_=prefs;preference=loadout_item2;task=input'>[loadout2 ? loadout2.name : "Выбрать"]</a>"

			dat += "<br><b>Персональный предмет III:</b> <a href='?_src_=prefs;preference=loadout_item3;task=input'>[loadout3 ? loadout3.name : "Выбрать"]</a>"

			dat += "</td>"

			dat += "</tr></table>"
//			-----------END OF BODY TABLE-----------
			dat += "</td>"
			dat += "</tr>"
			dat += "</table>"

		if (1) // Game Preferences
			used_title = "Настройки"
			dat += "<table><tr><td width='340px' height='300px' valign='top'>"
			dat += "<h2>Основные настройки</h2>"
//			dat += "<b>Стиль UI :</b> <a href='?_src_=prefs;task=input;preference=ui'>[UI_style]</a><br>"
			dat += "<b>tgui Мониторы:</b> <a href='?_src_=prefs;preference=tgui_lock'>[(tgui_lock) ? "Primary" : "All"]</a><br>"
//			dat += "<b>tgui Стиль:</b> <a href='?_src_=prefs;preference=tgui_fancy'>[(tgui_fancy) ? "Fancy" : "No Frills"]</a><br>"
//			dat += "<b>Show Runechat Chat Bubbles:</b> <a href='?_src_=prefs;preference=chat_on_map'>[chat_on_map ? "Enabled" : "Disabled"]</a><br>"
//			dat += "<b>Runechat message char limit:</b> <a href='?_src_=prefs;preference=max_chat_length;task=input'>[max_chat_length]</a><br>"
//			dat += "<b>See Runechat for non-mobs:</b> <a href='?_src_=prefs;preference=see_chat_non_mob'>[see_chat_non_mob ? "Enabled" : "Disabled"]</a><br>"
//			dat += "<br>"
//			dat += "<b>Action Buttons:</b> <a href='?_src_=prefs;preference=action_buttons'>[(buttons_locked) ? "Locked In Place" : "Unlocked"]</a><br>"
//			dat += "<b>Hotkey mode:</b> <a href='?_src_=prefs;preference=hotkeys'>[(hotkeys) ? "Hotkeys" : "Default"]</a><br>"
//			dat += "<br>"
//			dat += "<b>PDA Color:</b> <span style='border:1px solid #161616; background-color: [pda_color];'>&nbsp;&nbsp;&nbsp;</span> <a href='?_src_=prefs;preference=pda_color;task=input'>Change</a><BR>"
//			dat += "<b>PDA Style:</b> <a href='?_src_=prefs;task=input;preference=pda_style'>[pda_style]</a><br>"
//			dat += "<br>"
//			dat += "<b>Ghost Ears:</b> <a href='?_src_=prefs;preference=ghost_ears'>[(chat_toggles & CHAT_GHOSTEARS) ? "All Speech" : "Nearest Creatures"]</a><br>"
//			dat += "<b>Ghost Radio:</b> <a href='?_src_=prefs;preference=ghost_radio'>[(chat_toggles & CHAT_GHOSTRADIO) ? "All Messages":"No Messages"]</a><br>"
//			dat += "<b>Ghost Sight:</b> <a href='?_src_=prefs;preference=ghost_sight'>[(chat_toggles & CHAT_GHOSTSIGHT) ? "All Emotes" : "Nearest Creatures"]</a><br>"
//			dat += "<b>Ghost Whispers:</b> <a href='?_src_=prefs;preference=ghost_whispers'>[(chat_toggles & CHAT_GHOSTWHISPER) ? "All Speech" : "Nearest Creatures"]</a><br>"
//			dat += "<b>Ghost PDA:</b> <a href='?_src_=prefs;preference=ghost_pda'>[(chat_toggles & CHAT_GHOSTPDA) ? "All Messages" : "Nearest Creatures"]</a><br>"

/*			if(unlock_content)
				dat += "<b>Ghost Form:</b> <a href='?_src_=prefs;task=input;preference=ghostform'>[ghost_form]</a><br>"
				dat += "<B>Ghost Orbit: </B> <a href='?_src_=prefs;task=input;preference=ghostorbit'>[ghost_orbit]</a><br>"

			var/button_name = "If you see this something went wrong."
			switch(ghost_accs)
				if(GHOST_ACCS_FULL)
					button_name = GHOST_ACCS_FULL_NAME
				if(GHOST_ACCS_DIR)
					button_name = GHOST_ACCS_DIR_NAME
				if(GHOST_ACCS_NONE)
					button_name = GHOST_ACCS_NONE_NAME

			dat += "<b>Ghost Accessories:</b> <a href='?_src_=prefs;task=input;preference=ghostaccs'>[button_name]</a><br>"

			switch(ghost_others)
				if(GHOST_OTHERS_THEIR_SETTING)
					button_name = GHOST_OTHERS_THEIR_SETTING_NAME
				if(GHOST_OTHERS_DEFAULT_SPRITE)
					button_name = GHOST_OTHERS_DEFAULT_SPRITE_NAME
				if(GHOST_OTHERS_SIMPLE)
					button_name = GHOST_OTHERS_SIMPLE_NAME

			dat += "<b>Ghosts of Others:</b> <a href='?_src_=prefs;task=input;preference=ghostothers'>[button_name]</a><br>"
			dat += "<br>"

			dat += "<b>Income Updates:</b> <a href='?_src_=prefs;preference=income_pings'>[(chat_toggles & CHAT_BANKCARD) ? "Allowed" : "Muted"]</a><br>"
			dat += "<br>"
*/
			dat += "<b>FPS:</b> <a href='?_src_=prefs;preference=clientfps;task=input'>[clientfps]</a><br>"
/*
			dat += "<b>Parallax (Fancy Space):</b> <a href='?_src_=prefs;preference=parallaxdown' oncontextmenu='window.location.href=\"?_src_=prefs;preference=parallaxup\";return false;'>"
			switch (parallax)
				if (PARALLAX_LOW)
					dat += "Low"
				if (PARALLAX_MED)
					dat += "Medium"
				if (PARALLAX_INSANE)
					dat += "Insane"
				if (PARALLAX_DISABLE)
					dat += "Disabled"
				else
					dat += "High"
			dat += "</a><br>"
*/
//			dat += "<b>Fit Viewport:</b> <a href='?_src_=prefs;preference=auto_fit_viewport'>[auto_fit_viewport ? "Auto" : "Manual"]</a><br>"
//			if (CONFIG_GET(string/default_view) != CONFIG_GET(string/default_view_square))
//				dat += "<b>Widescreen:</b> <a href='?_src_=prefs;preference=widescreenpref'>[widescreenpref ? "Enabled ([CONFIG_GET(string/default_view)])" : "Disabled ([CONFIG_GET(string/default_view_square)])"]</a><br>"

/*			if (CONFIG_GET(flag/maprotation))
				var/p_map = preferred_map
				if (!p_map)
					p_map = "Default"
					if (config.defaultmap)
						p_map += " ([config.defaultmap.map_name])"
				else
					if (p_map in config.maplist)
						var/datum/map_config/VM = config.maplist[p_map]
						if (!VM)
							p_map += " (No longer exists)"
						else
							p_map = VM.map_name
					else
						p_map += " (No longer exists)"
				if(CONFIG_GET(flag/preference_map_voting))
					dat += "<b>Preferred Map:</b> <a href='?_src_=prefs;preference=preferred_map;task=input'>[p_map]</a><br>"
*/

//			dat += "<b>Play Lobby Music:</b> <a href='?_src_=prefs;preference=lobby_music'>[(toggles & SOUND_LOBBY) ? "Enabled":"Disabled"]</a><br>"


			dat += "</td><td width='300px' height='300px' valign='top'>"

			dat += "<h2>Настройки особых классов</h2>"

			if(is_banned_from(user.ckey, ROLE_SYNDICATE))
				dat += "<font color=red><b>Мне запрещено играть за злодейские классы.</b></font><br>"
				src.be_special = list()


			for (var/i in GLOB.special_roles_rogue)
				if(is_banned_from(user.ckey, i))
					dat += "<b>[capitalize(i)]:</b> <a href='?_src_=prefs;bancheck=[i]'>ЗАБАНЕН</a><br>"
				else
					var/days_remaining = null
					if(ispath(GLOB.special_roles_rogue[i]) && CONFIG_GET(flag/use_age_restriction_for_jobs)) //If it's a game mode antag, check if the player meets the minimum age
						days_remaining = get_remaining_days(user.client)

					if(days_remaining)
						dat += "<b>[capitalize(i)]:</b> <font color=red> \[ЧЕРЕЗ [days_remaining] ДНЕЙ]</font><br>"
					else
						dat += "<b>[capitalize(i)]:</b> <a href='?_src_=prefs;preference=be_special;be_special_type=[i]'>[(i in be_special) ? "Включено" : "Выключено"]</a><br>"
//			dat += "<br>"
//			dat += "<b>Midround Antagonist:</b> <a href='?_src_=prefs;preference=allow_midround_antag'>[(toggles & MIDROUND_ANTAG) ? "Enabled" : "Disabled"]</a><br>"
			dat += "</td></tr></table>"

		if(2) //OOC Preferences
			used_title = "ooc"
			dat += "<table><tr><td width='340px' height='300px' valign='top'>"
			dat += "<h2>OOC параметры</h2>"
			dat += "<b>Мерцание окна:</b> <a href='?_src_=prefs;preference=winflash'>[(windowflashing) ? "Enabled":"Disabled"]</a><br>"
			dat += "<br>"
			dat += "<b>Play Admin MIDIs:</b> <a href='?_src_=prefs;preference=hear_midis'>[(toggles & SOUND_MIDI) ? "Enabled":"Disabled"]</a><br>"
			dat += "<b>Play Lobby Music:</b> <a href='?_src_=prefs;preference=lobby_music'>[(toggles & SOUND_LOBBY) ? "Enabled":"Disabled"]</a><br>"
			dat += "<b>See Pull Requests:</b> <a href='?_src_=prefs;preference=pull_requests'>[(chat_toggles & CHAT_PULLR) ? "Enabled":"Disabled"]</a><br>"
			dat += "<br>"


			if(user.client)
				if(unlock_content)
					dat += "<b>BYOND Membership Publicity:</b> <a href='?_src_=prefs;preference=publicity'>[(toggles & MEMBER_PUBLIC) ? "Public" : "Hidden"]</a><br>"

				if(unlock_content || check_rights_for(user.client, R_ADMIN))
					dat += "<b>Цвет OOC:</b> <span style='border: 1px solid #161616; background-color: [ooccolor ? ooccolor : GLOB.normal_ooc_colour];'>&nbsp;&nbsp;&nbsp;</span> <a href='?_src_=prefs;preference=ooccolor;task=input'>Change</a><br>"

			dat += "</td>"

			if(user.client.holder)
				dat +="<td width='300px' height='300px' valign='top'>"

				dat += "<h2>Админ настройки</h2>"

				dat += "<b>Звуки Админхелпа:</b> <a href='?_src_=prefs;preference=hear_adminhelps'>[(toggles & SOUND_ADMINHELP)?"Включено":"Выключено"]</a><br>"
				dat += "<b>Звуки Игроков:</b> <a href = '?_src_=prefs;preference=hear_prayers'>[(toggles & SOUND_PRAYERS)?"Включено":"Выключено"]</a><br>"
				dat += "<b>Announce Login:</b> <a href='?_src_=prefs;preference=announce_login'>[(toggles & ANNOUNCE_LOGIN)?"Включено":"Выключено"]</a><br>"
				dat += "<br>"
				dat += "<b>Комбинированное HUD-освещение:</b> <a href = '?_src_=prefs;preference=combohud_lighting'>[(toggles & COMBOHUD_LIGHTING)?"Full-bright":"Без изменений"]</a><br>"
				dat += "<br>"
				dat += "<b>Скрыть чат мёртвых:</b> <a href = '?_src_=prefs;preference=toggle_dead_chat'>[(chat_toggles & CHAT_DSAY)?"Показано":"Скрыто"]</a><br>"
				dat += "<b>Скрыть радио:</b> <a href = '?_src_=prefs;preference=toggle_radio_chatter'>[(chat_toggles & CHAT_RADIO)?"Показано":"Скрыто"]</a><br>"
				dat += "<b>Скрыть шёпот:</b> <a href = '?_src_=prefs;preference=toggle_prayers'>[(chat_toggles & CHAT_PRAYER)?"Показано":"Скрыто"]</a><br>"
				if(CONFIG_GET(flag/allow_admin_asaycolor))
					dat += "<br>"
					dat += "<b>Цвет ASAY:</b> <span style='border: 1px solid #161616; background-color: [asaycolor ? asaycolor : "#FF4500"];'>&nbsp;&nbsp;&nbsp;</span> <a href='?_src_=prefs;preference=asaycolor;task=input'>Изменить</a><br>"

				//deadmin
				dat += "<h2>Deadmin While Playing</h2>"
				if(CONFIG_GET(flag/auto_deadmin_players))
					dat += "<b>Always Deadmin:</b> FORCED</a><br>"
				else
					dat += "<b>Always Deadmin:</b> <a href = '?_src_=prefs;preference=toggle_deadmin_always'>[(toggles & DEADMIN_ALWAYS)?"Enabled":"Disabled"]</a><br>"
					if(!(toggles & DEADMIN_ALWAYS))
						dat += "<br>"
						if(!CONFIG_GET(flag/auto_deadmin_antagonists))
							dat += "<b>As Antag:</b> <a href = '?_src_=prefs;preference=toggle_deadmin_antag'>[(toggles & DEADMIN_ANTAGONIST)?"Deadmin":"Keep Admin"]</a><br>"
						else
							dat += "<b>As Antag:</b> FORCED<br>"

						if(!CONFIG_GET(flag/auto_deadmin_heads))
							dat += "<b>As Command:</b> <a href = '?_src_=prefs;preference=toggle_deadmin_head'>[(toggles & DEADMIN_POSITION_HEAD)?"Deadmin":"Keep Admin"]</a><br>"
						else
							dat += "<b>As Command:</b> FORCED<br>"

				dat += "</td>"
			dat += "</tr></table>"

		if(3) // Custom keybindings
			used_title = "Keybinds"
			// Create an inverted list of keybindings -> key
			var/list/user_binds = list()
			for (var/key in key_bindings)
				for(var/kb_name in key_bindings[key])
					user_binds[kb_name] += list(key)

			var/list/kb_categories = list()
			// Group keybinds by category
			for (var/name in GLOB.keybindings_by_name)
				var/datum/keybinding/kb = GLOB.keybindings_by_name[name]
				kb_categories[kb.category] += list(kb)

			dat += "<style>label { display: inline-block; width: 200px; }</style><body>"

			for (var/category in kb_categories)
				for (var/i in kb_categories[category])
					var/datum/keybinding/kb = i
					if(!length(user_binds[kb.name]))
						dat += "<label>[kb.full_name]</label> <a href ='?_src_=prefs;preference=keybindings_capture;keybinding=[kb.name];old_key=["Unbound"]'>Unbound</a>"
//						var/list/default_keys = hotkeys ? kb.hotkey_keys : kb.classic_keys
//						if(LAZYLEN(default_keys))
//							dat += "| Default: [default_keys.Join(", ")]"
						dat += "<br>"
					else
						var/bound_key = user_binds[kb.name][1]
						dat += "<label>[kb.full_name]</label> <a href ='?_src_=prefs;preference=keybindings_capture;keybinding=[kb.name];old_key=[bound_key]'>[bound_key]</a>"
						for(var/bound_key_index in 2 to length(user_binds[kb.name]))
							bound_key = user_binds[kb.name][bound_key_index]
							dat += " | <a href ='?_src_=prefs;preference=keybindings_capture;keybinding=[kb.name];old_key=[bound_key]'>[bound_key]</a>"
						if(length(user_binds[kb.name]) < MAX_KEYS_PER_KEYBIND)
							dat += "| <a href ='?_src_=prefs;preference=keybindings_capture;keybinding=[kb.name]'>Add Secondary</a>"
						var/list/default_keys = hotkeys ? kb.classic_keys : kb.hotkey_keys
						if(LAZYLEN(default_keys))
							dat += "| Default: [default_keys.Join(", ")]"
						dat += "<br>"

			dat += "<br><br>"
			dat += "<a href ='?_src_=prefs;preference=keybinds;task=keybindings_set'>\[Вернуться к значениям по умолчанию\]</a>"
			dat += "</body>"


	if(!IsGuestKey(user.key))
		dat += "<a href='?_src_=prefs;preference=save'>Сохранить</a><br>"
		dat += "<a href='?_src_=prefs;preference=load'>Отменить</a><br>"

	// well.... one empty slot here for something I suppose lol
	dat += "<table width='100%'>"
	dat += "<tr>"
	dat += "<td width='33%' align='left'>"
	dat += "<b>Затенение (AO):</b> <a href='?_src_=prefs;preference=ambientocclusion'>[ambientocclusion ? "Включено" : "Выключено"]</a><br>"
	dat += "</td>"
	dat += "<td width='33%' align='center'>"
	var/mob/dead/new_player/N = user
	if(istype(N))
		//dat += "<a href='?_src_=prefs;preference=bespecial'><b>[next_special_trait ? "<font color='red'>SPECIAL</font>" : "Be Special"]</b></a><BR>"
		if(SSticker.current_state <= GAME_STATE_PREGAME)
			switch(N.ready)
				if(PLAYER_NOT_READY)
					dat += "<b>НЕ ГОТОВ</b> <a href='byond://?src=[REF(N)];ready=[PLAYER_READY_TO_PLAY]'>ГОТОВ</a>"
				if(PLAYER_READY_TO_PLAY)
					dat += "<a href='byond://?src=[REF(N)];ready=[PLAYER_NOT_READY]'>НЕ ГОТОВ</a> <b>ГОТОВ</b>"
					log_game("([user || "NO KEY"]) readied as ([real_name])")
		else
			if(!is_active_migrant())
				dat += "<a href='byond://?src=[REF(N)];late_join=1'>ПРИСОЕДИНИТЬСЯ</a>"
			else
				dat += "<a class='linkOff' href='byond://?src=[REF(N)];late_join=1'>ПРИСОЕДИНИТЬСЯ</a>"
			dat += "<br><a href='?_src_=prefs;preference=migrants'>ПЕРЕСЕЛЕНИЕ</a>"
			dat += "<br><a href='?_src_=prefs;preference=manifest'>ДЕЙСТВУЮЩИЕ ЛИЦА</a>"
			dat += "<br><a href='?_src_=prefs;preference=observe'>НАБЛЮДАТЬ</a>"
	else
		dat += "<a href='?_src_=prefs;preference=finished'>ГОТОВО</a>"

	dat += "</td>"
	dat += "<td width='33%' align='right'>"
	dat += "<b>Быть строптивым(-ой):</b> <a href='?_src_=prefs;preference=be_defiant'>[(defiant) ? "Да":"Нет"]</a><br>" // ! REDMOON
	dat += "<b>Быть Гласом:</b> <a href='?_src_=prefs;preference=schizo_voice'>[(toggles & SCHIZO_VOICE) ? "Да":"Нет"]</a>"
	dat += "<br><b>Звуки администраторов:</b> <a href='?_src_=prefs;preference=hear_midis'>[(toggles & SOUND_MIDI) ? "Включены":"Выключены"]</a>"
	dat += "</td>"
	dat += "</tr>"
	dat += "</table>"
//	dat += "<a href='?_src_=prefs;preference=reset_all'> настройки</a>"


	if(user.client.is_new_player())
		dat = list("<center>ЗАРЕГИСТРИРОВАН!</center>")

	winshow(user, "preferencess_window", TRUE)
	winset(user, "preferencess_window", "size=820x850")
	winset(user, "preferencess_window", "pos=280,80")
	var/datum/browser/noclose/popup = new(user, "preferences_browser", "<div align='center'>[used_title]</div>")
	popup.set_window_options("can_close=0")
	popup.set_content(dat.Join())
	popup.open(FALSE)
	update_preview_icon()
//	onclose(user, "preferencess_window", src)

#undef APPEARANCE_CATEGORY_COLUMN
#undef MAX_MUTANT_ROWS

/datum/preferences/proc/CaptureKeybinding(mob/user, datum/keybinding/kb, old_key)
	var/HTML = {"
	<div id='focus' style="outline: 0;" tabindex=0>Keybinding: [kb.full_name]<br>[kb.description]<br><br><b>Нажмите любую кнопку что бы сменить<br>Нажмите ESC чтобы очистить</b></div>
	<script>
	var deedDone = false;
	document.onkeyup = function(e) {
		if(deedDone){ return; }
		var alt = e.altKey ? 1 : 0;
		var ctrl = e.ctrlKey ? 1 : 0;
		var shift = e.shiftKey ? 1 : 0;
		var numpad = (95 < e.keyCode && e.keyCode < 112) ? 1 : 0;
		var escPressed = e.keyCode == 27 ? 1 : 0;
		var url = 'byond://?_src_=prefs;preference=keybinds;task=keybindings_set;keybinding=[kb.name];old_key=[old_key];clear_key='+escPressed+';key='+e.key+';alt='+alt+';ctrl='+ctrl+';shift='+shift+';numpad='+numpad+';key_code='+e.keyCode;
		window.location=url;
		deedDone = true;
	}
	document.getElementById('focus').focus();
	</script>
	"}
	winshow(user, "capturekeypress", TRUE)
	var/datum/browser/noclose/popup = new(user, "capturekeypress", "<div align='center'>Keybindings</div>", 350, 300)
	popup.set_content(HTML)
	popup.open(FALSE)
	onclose(user, "capturekeypress", src)

/datum/preferences/proc/SetChoices(mob/user, limit = 14, list/splitJobs = list("Court Magician", "Knight Captain", "Bishop", "Merchant", "Archivist", "Towner", "Grenzelhoft Mercenary", "Beggar", "Prisoner", "Goblin King"), widthPerColumn = 295, height = 620) //295 620
	if(!SSjob)
		return

	//limit - The amount of jobs allowed per column. Defaults to 17 to make it look nice.
	//splitJobs - Allows you split the table by job. You can make different tables for each department by including their heads. Defaults to CE to make it look nice.
	//widthPerColumn - Screen's width for every column.
	//height - Screen's height.

	var/width = widthPerColumn

	var/HTML = "<center>"
	if(SSjob.occupations.len <= 0)
//		HTML += "The job SSticker is not yet finished creating jobs, please try again later"
		HTML += "<center><a href='?_src_=prefs;preference=job;task=close'>Сохранить</a></center><br>" // Easier to press up here.

	else
//		HTML += "<b>Choose class preferences</b><br>"
//		HTML += "<div align='center'>Left-click to raise a class preference, right-click to lower it.<br></div>"
		HTML += "<center><a href='?_src_=prefs;preference=job;task=close'>Сохранить</a></center>" // Easier to press up here.
		if(joblessrole != RETURNTOLOBBY && joblessrole != BERANDOMJOB) // this is to catch those that used the previous definition and reset.
			joblessrole = RETURNTOLOBBY
		HTML += "<i>Нажмите на разблокированный класс, чтобы получить дополнительную информацию.</i><br>"
		HTML += "<b>Если класс недоступен:</b><font color='purple'><a href='?_src_=prefs;preference=job;task=nojob'>[joblessrole]</a></font><BR>"
		HTML += "<script type='text/javascript'>function setJobPrefRedirect(level, rank) { window.location.href='?_src_=prefs;preference=job;task=setJobLevel;level=' + level + ';text=' + encodeURIComponent(rank); return false; }</script>"
		HTML += "<table width='100%' cellpadding='1' cellspacing='0'><tr><td width='20%'>" // Table within a table for alignment, also allows you to easily add more colomns.
		HTML += "<table width='100%' cellpadding='1' cellspacing='0'>"
		var/index = -1

		//The job before the current job. I only use this to get the previous jobs color when I'm filling in blank rows.
		var/datum/job/lastJob
		for(var/datum/job/job in sortList(SSjob.occupations, GLOBAL_PROC_REF(cmp_job_display_asc)))
			if(!job.spawn_positions)
				continue

			index += 1
//			if((index >= limit) || (job.title in splitJobs))
			if(index >= limit)
				width += widthPerColumn
				if((index < limit) && (lastJob != null))
					//If the cells were broken up by a job in the splitJob list then it will fill in the rest of the cells with
					//the last job's selection color. Creating a rather nice effect.
					for(var/i = 0, i < (limit - index), i += 1)
						HTML += "<tr bgcolor='#000000'><td width='60%' align='right'>&nbsp</td><td>&nbsp</td></tr>"
				HTML += "</table></td><td width='20%'><table width='100%' cellpadding='1' cellspacing='0'>"
				index = 0

			if(job.title in splitJobs)
				HTML += "<tr bgcolor='#000000'><td width='60%' align='right'><hr></td></tr>"

			HTML += "<tr bgcolor='#000000'><td width='60%' align='right'>"
			var/rank = job.title
			var/used_name = job.display_title || job.title
			if((pronouns == SHE_HER || pronouns == THEY_THEM_F) && job.f_title)
				used_name = "[job.f_title]"
			lastJob = job
			if(is_banned_from(user.ckey, rank))
				HTML += "[used_name]</td> <td><a href='?_src_=prefs;bancheck=[rank]'> ЗАБАНЕН</a></td></tr>"
				continue
			var/required_playtime_remaining = job.required_playtime_remaining(user.client)
			if(required_playtime_remaining)
				HTML += "[used_name]</td> <td><font color=red> \[ [get_exp_format(required_playtime_remaining)] в качестве [job.get_exp_req_type()] \] </font></td></tr>"
				continue
			if(!job.player_old_enough(user.client))
				var/available_in_days = job.available_in_days(user.client)
				HTML += "[used_name]</td> <td><font color=red> \[IN [(available_in_days)] DAYS\]</font></td></tr>"
				continue
			#ifdef USES_PQ
			if(!job.required && !isnull(job.min_pq) && (get_playerquality(user.ckey) < job.min_pq))
				HTML += "<font color=#a59461>[used_name] (Минимум PQ: [job.min_pq])</font></td> <td> </td></tr>"
				continue
			#endif
			if(!job.required && !isnull(job.max_pq) && (get_playerquality(user.ckey) > job.max_pq))
				HTML += "<font color=#a59461>[used_name] (Максимум PQ: [job.max_pq])</font></td> <td> </td></tr>"
				continue
			if(length(job.virtue_restrictions) && length(job.vice_restrictions))
				var/name
				if(virtue.type in job.virtue_restrictions)
					name = virtue.name
				if(virtuetwo?.type in job.virtue_restrictions)
					if(name)
						name += ", "
						name += virtuetwo.name
					else
						name = virtuetwo.name
				if(charflaw.type in job.vice_restrictions)
					if(name)
						name += ", "
						name += charflaw.name
					else
						name += charflaw.name
				if(!isnull(name))
					HTML += "<font color='#a561a5'>[used_name] (Запрещено достоинством / пороком: [name])</font></td> <td> </td></tr>"
			if(length(job.virtue_restrictions))
				var/name
				if(virtue.type in job.virtue_restrictions)
					name = virtue.name
				if(virtuetwo?.type in job.virtue_restrictions)
					if(name)
						name += ", "
						name += virtuetwo.name
					else
						name = virtuetwo.name
				if(!isnull(name))
					HTML += "<font color='#a59461'>[used_name] (Запрещено достоинством: [name])</font></td> <td> </td></tr>"
					continue
			if(length(job.vice_restrictions))
				if(charflaw.type in job.vice_restrictions)
					HTML += "<font color='#a56161'>[used_name] (Запрещено пороком: [charflaw.name])</font></td> <td> </td></tr>"
					continue
			var/job_unavailable = JOB_AVAILABLE
			if(isnewplayer(parent?.mob))
				var/mob/dead/new_player/new_player = parent.mob
				job_unavailable = new_player.IsJobUnavailable(job.title, latejoin = FALSE)
			var/static/list/acceptable_unavailables = list(
				JOB_AVAILABLE,
				JOB_UNAVAILABLE_SLOTFULL,
			)
			if(!(job_unavailable in acceptable_unavailables))
				HTML += "<font color=#a36c63>[used_name]</font></td> <td> </td></tr>"
				continue

			var/job_display = used_name
			//job_display += " <a href='?src=[REF(job)];explainjob=1'>{?}</a></span>"
//			if((job_preferences[SSjob.overflow_role] == JP_LOW) && (rank != SSjob.overflow_role) && !is_banned_from(user.ckey, SSjob.overflow_role))
//				HTML += "<font color=orange>[rank]</font></td><td></td></tr>"
//				continue
/*			if((rank in GLOB.command_positions) || (rank == "AI"))//Bold head jobs
				HTML += "<b><span class='dark'><a href='?_src_=prefs;preference=job;task=tutorial;tut='[job.tutorial]''>[used_name]</a></span></b>"
			else
				HTML += span_dark("<a href='?_src_=prefs;preference=job;task=tutorial;tut='[job.tutorial]''>[used_name]</a>")*/

			HTML += {"

<style>


.tutorialhover {
	position: relative;
	display: inline-block;
	border-bottom: 1px dotted black;
}

.tutorialhover .tutorial {

	visibility: hidden;
	width: 280px;
	background-color: black;
	color: #e3c06f;
	text-align: center;
	border-radius: 6px;
	padding: 5px 0;

	position: absolute;
	z-index: 1;
	top: 100%;
	left: 50%;
	margin-left: -140px;
}

.tutorialhover:hover .tutorial{
	visibility: visible;
}

</style>

<div class="tutorialhover"> [job.class_setup_examine ? "<a href='?src=[REF(job)];explainjob=1'><font>[job_display]</font></a>" : "<font>[job_display]</font>"]</span>
<span class="tutorial">[job.tutorial]<br>
Slots: [job.spawn_positions] [job.round_contrib_points ? "RCP: +[job.round_contrib_points]" : ""]</span>
</div>

			"}

			HTML += "</td><td width='40%'>"

			var/prefLevelLabel = "ERROR"
			var/prefLevelColor = "pink"
			var/prefUpperLevel = -1 // level to assign on left click
			var/prefLowerLevel = -1 // level to assign on right click

			switch(job_preferences[job.title])
				if(JP_HIGH)
					prefLevelLabel = "High"
					prefLevelColor = "slateblue"
					prefUpperLevel = 4
					prefLowerLevel = 2
					var/mob/dead/new_player/P = user
					if(istype(P))
						P.topjob = job.title
				if(JP_MEDIUM)
					prefLevelLabel = "Medium"
					prefLevelColor = "green"
					prefUpperLevel = 1
					prefLowerLevel = 3
				if(JP_LOW)
					prefLevelLabel = "Low"
					prefLevelColor = "orange"
					prefUpperLevel = 2
					prefLowerLevel = 4
				else
					prefLevelLabel = "NEVER"
					prefLevelColor = "red"
					prefUpperLevel = 3
					prefLowerLevel = 1

			HTML += "<a class='white' href='?_src_=prefs;preference=job;task=setJobLevel;level=[prefUpperLevel];text=[rank]' oncontextmenu='javascript:return setJobPrefRedirect([prefLowerLevel], \"[rank]\");'>"

//			if(rank == SSjob.overflow_role)//Overflow is special
//				if(job_preferences[SSjob.overflow_role] == JP_LOW)
//					HTML += "<font color=green>Yes</font>"
//				else
//					HTML += "<font color=red>No</font>"
//				HTML += "</a></td></tr>"
//				continue

			HTML += "<font color=[prefLevelColor]>[prefLevelLabel]</font>"
			HTML += "</a></td></tr>"

		for(var/i = 1, i < (limit - index), i += 1) // Finish the column so it is even
			HTML += "<tr bgcolor='000000'><td width='60%' align='right'>&nbsp</td><td>&nbsp</td></tr>"

		HTML += "</td'></tr></table>"
		HTML += "</center></table><br>"

//		var/message = "Be an [SSjob.overflow_role] if preferences unavailable"
//		if(joblessrole == BERANDOMJOB)
//			message = "Получить случайную роль если роли не доступны"
//		else if(joblessrole == RETURNTOLOBBY)
//			message = "Вернитесь в лобби, если роли недоступны"
//		HTML += "<center><br><a href='?_src_=prefs;preference=job;task=random'>[message]</a></center>"
		if(user.client.prefs.lastclass)
			HTML += "<center><a href='?_src_=prefs;preference=job;task=triumphthing'>ПОИГРАЙТЕ ЗА [user.client.prefs.lastclass] СНОВА</a></center>"
		else
			HTML += "<br>"
		HTML += "<center><a href='?_src_=prefs;preference=job;task=reset'>Сброс</a></center>"

	var/datum/browser/noclose/popup = new(user, "mob_occupation", "<div align='center'>Выбор класса</div>", width, height)
	popup.set_window_options("can_close=0")
	popup.set_content(HTML)
	popup.open(FALSE)

/datum/preferences/proc/SetJobPreferenceLevel(datum/job/job, level)
	if (!job)
		return FALSE

	if (level == JP_HIGH) // to high
		//Set all other high to medium
		for(var/j in job_preferences)
			if(job_preferences[j] == JP_HIGH)
				job_preferences[j] = JP_MEDIUM
				//technically break here

	job_preferences[job.title] = level
	return TRUE

/datum/preferences/proc/UpdateJobPreference(mob/user, role, desiredLvl)
	if(!SSjob || SSjob.occupations.len <= 0)
		return
	var/datum/job/job = SSjob.GetJob(role)

	if(!job)
		user << browse(null, "window=mob_occupation")
		ShowChoices(user,4)
		return

	if (!isnum(desiredLvl))
		to_chat(user, span_danger("UpdateJobPreference - desired level was not a number. Please notify coders!"))
		ShowChoices(user,4)
		return

	var/jpval = null
	switch(desiredLvl)
		if(3)
			jpval = JP_LOW
		if(2)
			jpval = JP_MEDIUM
		if(1)
			jpval = JP_HIGH

	#ifdef USES_PQ
	if(job.required && !isnull(job.min_pq) && (get_playerquality(user.ckey) < job.min_pq))
		if(job_preferences[job.title] == JP_LOW)
			jpval = null
		else
			var/used_name = job.display_title || job.title
			if((pronouns == SHE_HER || pronouns == THEY_THEM_F) && job.f_title)
				used_name = "[job.f_title]"
			to_chat(user, "<font color='red'>У вас слишком мало PQ для [used_name] (Минимум PQ: [job.min_pq]).</font>")
			jpval = JP_LOW
	#endif

	SetJobPreferenceLevel(job, jpval)
	SetChoices(user)

	return 1


/datum/preferences/proc/ResetJobs()
	job_preferences = list()

/datum/preferences/proc/ResetLastClass(mob/user)
	if(user.client?.prefs)
		if(!user.client.prefs.lastclass)
			return
	var/choice = tgalert(user, "Потратить 2 триумфа, чтобы сыграть за этот класс снова?", "Сбросить класс", "Сделать это", "Отмена")
	if(choice == "Отмена")
		return
	if(!choice)
		return
	if(user.client?.prefs)
		if(user.client.prefs.lastclass)
			if(user.get_triumphs() < 2)
				to_chat(user, span_warning("Я недостаточно ТРИУМФАЛЕН"))
				return
			user.adjust_triumphs(-2)
			user.client.prefs.lastclass = null
			user.client.prefs.save_preferences()

/datum/preferences/proc/SetKeybinds(mob/user)
	var/list/dat = list()
	// Create an inverted list of keybindings -> key
	var/list/user_binds = list()
	for (var/key in key_bindings)
		for(var/kb_name in key_bindings[key])
			user_binds[kb_name] += list(key)

	var/list/kb_categories = list()
	// Group keybinds by category
	for (var/name in GLOB.keybindings_by_name)
		var/datum/keybinding/kb = GLOB.keybindings_by_name[name]
		kb_categories[kb.category] += list(kb)

	dat += "<style>label { display: inline-block; width: 200px; }</style><body>"

	dat += "<center><a href='?_src_=prefs;preference=keybinds;task=close'>Сохранить</a></center><br>"
	for (var/category in kb_categories)
		for (var/i in kb_categories[category])
			var/datum/keybinding/kb = i
			if(!length(user_binds[kb.name]))
				dat += "<label>[kb.full_name]</label> <a href ='?_src_=prefs;preference=keybinds;task=keybindings_capture;keybinding=[kb.name];old_key=["Unbound"]'>Не выставлена</a>"
//						var/list/default_keys = hotkeys ? kb.hotkey_keys : kb.classic_keys
//						if(LAZYLEN(default_keys))
//							dat += "| Default: [default_keys.Join(", ")]"
				dat += "<br>"
			else
				var/bound_key = user_binds[kb.name][1]
				dat += "<label>[kb.full_name]</label> <a href ='?_src_=prefs;preference=keybinds;task=keybindings_capture;keybinding=[kb.name];old_key=[bound_key]'>[bound_key]</a>"
				for(var/bound_key_index in 2 to length(user_binds[kb.name]))
					bound_key = user_binds[kb.name][bound_key_index]
					dat += " | <a href ='?_src_=prefs;preference=keybinds;task=keybindings_capture;keybinding=[kb.name];old_key=[bound_key]'>[bound_key]</a>"
				if(length(user_binds[kb.name]) < MAX_KEYS_PER_KEYBIND)
					dat += "| <a href ='?_src_=prefs;preference=keybinds;task=keybindings_capture;keybinding=[kb.name]'>Добавить новую</a>"
				dat += "<br>"

	dat += "<br><br>"
	dat += "<a href ='?_src_=prefs;preference=keybinds;task=keybindings_reset'>\[Вернуться к значениям по умолчанию\]</a>"
	dat += "</body>"

	var/datum/browser/noclose/popup = new(user, "keybind_setup", "<div align='center'>Горячие клавиши</div>", 600, 600) //no reason not to reuse the occupation window, as it's cleaner that way
	popup.set_window_options("can_close=0")
	popup.set_content(dat.Join())
	popup.open(FALSE)

/datum/preferences/proc/SetAntag(mob/user)
	var/list/dat = list()

	dat += "<style>label { display: inline-block; width: 200px; }</style><body>"

	dat += "<center><a href='?_src_=prefs;preference=antag;task=close'>Done</a></center><br>"


	if(is_banned_from(user.ckey, ROLE_SYNDICATE))
		dat += "<font color=red><b>Мне запрещено играть за злодейские классы..</b></font><br>"
		src.be_special = list()


	for (var/i in GLOB.special_roles_rogue)
		if(is_banned_from(user.ckey, i))
			dat += "<b>[capitalize(i)]:</b> <a href='?_src_=prefs;bancheck=[i]'>ЗАБАНЕН</a><br>"
		else
			var/days_remaining = null
			if(ispath(GLOB.special_roles_rogue[i]) && CONFIG_GET(flag/use_age_restriction_for_jobs)) //If it's a game mode antag, check if the player meets the minimum age
				days_remaining = get_remaining_days(user.client)

			if(days_remaining)
				dat += "<b>[capitalize(i)]:</b> <font color=red> \[ЧЕРЕЗ [days_remaining] ДНЕЙ]</font><br>"
			else
				dat += "<b>[capitalize(i)]:</b> <a href='?_src_=prefs;preference=antag;task=be_special;be_special_type=[i]'>[(i in be_special) ? "Включено" : "Выключено"]</a><br>"


	dat += "</body>"

	var/datum/browser/noclose/popup = new(user, "antag_setup", "<div align='center'>Особые классы</div>", 250, 300) //no reason not to reuse the occupation window, as it's cleaner that way
	popup.set_window_options("can_close=0")
	popup.set_content(dat.Join())
	popup.open(FALSE)


/datum/preferences/Topic(href, href_list, hsrc)			//yeah, gotta do this I guess..
	. = ..()
	if(href_list["close"])
		var/client/C = usr.client
		if(C)
			C.clear_character_previews()

/datum/preferences/proc/process_link(mob/user, list/href_list)
	if(href_list["bancheck"])
		var/list/ban_details = is_banned_from_with_details(user.ckey, user.client.address, user.client.computer_id, href_list["bancheck"])
		var/admin = FALSE
		if(GLOB.admin_datums[user.ckey] || GLOB.deadmins[user.ckey])
			admin = TRUE
		for(var/i in ban_details)
			if(admin && !text2num(i["applies_to_admins"]))
				continue
			ban_details = i
			break //we only want to get the most recent ban's details
		if(ban_details && ban_details.len)
			var/expires = "This is a permanent ban."
			if(ban_details["expiration_time"])
				expires = " The ban is for [DisplayTimeText(text2num(ban_details["duration"]) MINUTES)] and expires on [ban_details["expiration_time"]] (server time)."
			to_chat(user, span_danger("You, or another user of this computer or connection ([ban_details["key"]]) is banned from playing [href_list["bancheck"]].<br>The ban reason is: [ban_details["reason"]]<br>This ban (BanID #[ban_details["id"]]) was applied by [ban_details["admin_key"]] on [ban_details["bantime"]] during round ID [ban_details["round_id"]].<br>[expires]"))
			return
	if(href_list["preference"] == "job")
		switch(href_list["task"])
			if("close")
				user << browse(null, "window=mob_occupation")
				ShowChoices(user,4)
			if("reset")
				ResetJobs()
				SetChoices(user)
			if("triumphthing")
				ResetLastClass(user)
			if("nojob")
				switch(joblessrole)
					if(RETURNTOLOBBY)
						joblessrole = BERANDOMJOB
					if(BERANDOMJOB)
						joblessrole = RETURNTOLOBBY
				SetChoices(user)
			if("tutorial")
				if(href_list["tut"])
					testing("[href_list["tut"]]")
					to_chat(user, span_info("* ----------------------- *"))
					to_chat(user, href_list["tut"])
					to_chat(user, span_info("* ----------------------- *"))
			if("random")
				switch(joblessrole)
					if(RETURNTOLOBBY)
						if(is_banned_from(user.ckey, SSjob.overflow_role))
							joblessrole = BERANDOMJOB
						else
							joblessrole = BERANDOMJOB
					if(BEOVERFLOW)
						joblessrole = BERANDOMJOB
					if(BERANDOMJOB)
						joblessrole = BERANDOMJOB
				SetChoices(user)
			if("setJobLevel")
				if(SSticker.job_change_locked)
					return 1
				UpdateJobPreference(user, href_list["text"], text2num(href_list["level"]))
			else
				SetChoices(user)
		return 1

	else if(href_list["preference"] == "antag")
		switch(href_list["task"])
			if("close")
				user << browse(null, "window=antag_setup")
				ShowChoices(user)
			if("be_special")
				var/be_special_type = href_list["be_special_type"]
				if(be_special_type in be_special)
					be_special -= be_special_type
				else
					be_special += be_special_type
				SetAntag(user)
			if("update")
				SetAntag(user)
			else
				SetAntag(user)
	else if(href_list["preference"] == "tgui_ui_prefs")
		tgui_pref = !tgui_pref
	else if(href_list["preference"] == "triumphs")
		user.show_triumphs_list()

	else if(href_list["preference"] == "playerquality")
		check_pq_menu(user.ckey)

	else if(href_list["preference"] == "agevet")
		if(!user.check_agevet())
			to_chat(usr, span_info("- You are a whitelisted player with full access to the server's features. If you'd also like to show others that you've been <b>AGE-VERIFIED</b> with a censored ID, you can open a ticket in Scarlet Dawn's <b>#vet-here</b> channel. Note that this is a purely optional process, and - besides awarding a special header for your flavortext - doesn't affect you in any other way."))
		else
			to_chat(usr, span_love("- Ваш возраст подтверждён!"))

	else if(href_list["preference"] == "culinary")
		show_culinary_ui(user)
		return
	else if(href_list["preference"] == "markings")
		ShowMarkings(user)
		return
	else if(href_list["preference"] == "descriptors")
		show_descriptors_ui(user)
		return

	else if(href_list["preference"] == "customizers")
		ShowCustomizers(user)
		return
	else if(href_list["preference"] == "triumph_buy_menu")
		SStriumphs.startup_triumphs_menu(user.client)

	else if(href_list["preference"] == "keybinds")
		switch(href_list["task"])
			if("close")
				user << browse(null, "window=keybind_setup")
				ShowChoices(user)
			if("update")
				SetKeybinds(user)
			if("keybindings_capture")
				var/datum/keybinding/kb = GLOB.keybindings_by_name[href_list["keybinding"]]
				var/old_key = href_list["old_key"]
				CaptureKeybinding(user, kb, old_key)
				return

			if("keybindings_set")
				var/kb_name = href_list["keybinding"]
				if(!kb_name)
					user << browse(null, "window=capturekeypress")
					SetKeybinds(user)
					return

				var/clear_key = text2num(href_list["clear_key"])
				var/old_key = href_list["old_key"]
				if(clear_key)
					if(key_bindings[old_key])
						key_bindings[old_key] -= kb_name
						if(!length(key_bindings[old_key]))
							key_bindings -= old_key
					user << browse(null, "window=capturekeypress")
					save_preferences()
					SetKeybinds(user)
					return

				var/new_key = uppertext(href_list["key"])
				var/AltMod = text2num(href_list["alt"]) ? "Alt" : ""
				var/CtrlMod = text2num(href_list["ctrl"]) ? "Ctrl" : ""
				var/ShiftMod = text2num(href_list["shift"]) ? "Shift" : ""
				var/numpad = text2num(href_list["numpad"]) ? "Numpad" : ""
				// var/key_code = text2num(href_list["key_code"])

				if(GLOB._kbMap[new_key])
					new_key = GLOB._kbMap[new_key]

				var/full_key
				switch(new_key)
					if("Alt")
						full_key = "[new_key][CtrlMod][ShiftMod]"
					if("Ctrl")
						full_key = "[AltMod][new_key][ShiftMod]"
					if("Shift")
						full_key = "[AltMod][CtrlMod][new_key]"
					else
						full_key = "[AltMod][CtrlMod][ShiftMod][numpad][new_key]"
				if(key_bindings[old_key])
					key_bindings[old_key] -= kb_name
					if(!length(key_bindings[old_key]))
						key_bindings -= old_key
				key_bindings[full_key] += list(kb_name)
				key_bindings[full_key] = sortList(key_bindings[full_key])

				user << browse(null, "window=capturekeypress")
				user.client.update_movement_keys()
				save_preferences()
				SetKeybinds(user)

			if("keybindings_reset")
				var/choice = tgalert(user, "Вы правда хотите сбросить горячие клавиши?", "Сброс горячих клавиш", "Подтвердить", "Отмена")
				if(choice == "Отмена")
					ShowChoices(user,3)
					return
				hotkeys = (choice == "Подтвердить")
				key_bindings = (hotkeys) ? deepCopyList(GLOB.hotkey_keybinding_list_by_key) : deepCopyList(GLOB.classic_keybinding_list_by_key)
				user.client.update_movement_keys()
				SetKeybinds(user)
			else
				SetKeybinds(user)
		return TRUE

	switch(href_list["task"])
		if("change_customizer")
			handle_customizer_topic(user, href_list)
			ShowChoices(user)
			ShowCustomizers(user)
			return
		if("change_marking")
			handle_body_markings_topic(user, href_list)
			ShowChoices(user)
			ShowMarkings(user)
			return
		if("change_descriptor")
			handle_descriptors_topic(user, href_list)
			show_descriptors_ui(user)
			return
		if("change_culinary_preferences")
			handle_culinary_topic(user, href_list)
			show_culinary_ui(user)
			return
		if("random")
			switch(href_list["preference"])
				if("name")
					real_name = pref_species.random_name(gender,1)
				if("age")
					age = pick(pref_species.possible_ages)
				if("eyes")
					eye_color = random_eye_color()
				if("s_tone")
					var/list/skins = pref_species.get_skin_list()
					skin_tone = skins[pick(skins)]
				if("species")
					random_species()
				if("bag")
					backpack = pick(GLOB.backpacklist)
				if("suit")
					jumpsuit_style = PREF_SUIT
				if("all")
					random_character(gender, FALSE, FALSE)

		if("input")

			if(href_list["preference"] in GLOB.preferences_custom_names)
				ask_for_custom_name(user,href_list["preference"])

			switch(href_list["preference"])
				if("ghostform")
					if(unlock_content)
						var/new_form = input(user, "Thanks for supporting BYOND - Choose your ghostly form:","Thanks for supporting BYOND",null) as null|anything in GLOB.ghost_forms
						if(new_form)
							ghost_form = new_form
				if("ghostorbit")
					if(unlock_content)
						var/new_orbit = input(user, "Thanks for supporting BYOND - Choose your ghostly orbit:","Thanks for supporting BYOND", null) as null|anything in GLOB.ghost_orbits
						if(new_orbit)
							ghost_orbit = new_orbit

				if("ghostaccs")
					var/new_ghost_accs = alert("Do you want your ghost to show full accessories where possible, hide accessories but still use the directional sprites where possible, or also ignore the directions and stick to the default sprites?",,GHOST_ACCS_FULL_NAME, GHOST_ACCS_DIR_NAME, GHOST_ACCS_NONE_NAME)
					switch(new_ghost_accs)
						if(GHOST_ACCS_FULL_NAME)
							ghost_accs = GHOST_ACCS_FULL
						if(GHOST_ACCS_DIR_NAME)
							ghost_accs = GHOST_ACCS_DIR
						if(GHOST_ACCS_NONE_NAME)
							ghost_accs = GHOST_ACCS_NONE

				if("ghostothers")
					var/new_ghost_others = alert("Do you want the ghosts of others to show up as their own setting, as their default sprites or always as the default white ghost?",,GHOST_OTHERS_THEIR_SETTING_NAME, GHOST_OTHERS_DEFAULT_SPRITE_NAME, GHOST_OTHERS_SIMPLE_NAME)
					switch(new_ghost_others)
						if(GHOST_OTHERS_THEIR_SETTING_NAME)
							ghost_others = GHOST_OTHERS_THEIR_SETTING
						if(GHOST_OTHERS_DEFAULT_SPRITE_NAME)
							ghost_others = GHOST_OTHERS_DEFAULT_SPRITE
						if(GHOST_OTHERS_SIMPLE_NAME)
							ghost_others = GHOST_OTHERS_SIMPLE

				if("name")
					var/new_name = tgui_input_text(user, "Имя этой оболочки?", "ИДЕНТИЧНОСТЬ", encode = FALSE)
					if(new_name)
						new_name = reject_bad_name(new_name)
						if(new_name)
							real_name = new_name
						else
							to_chat(user, "<font color='red'>Неверное имя. Длина имени должна быть не менее 2 и не более [MAX_NAME_LEN] символов. Оно может содержать только символы A-Z, a-z, -, ', . and ,.</font>")

				if("nickname")
					var/new_name = tgui_input_text(user, "Выберите прозвище вашего персонажа (Для подсветки):", "ПРОЗВИЩЕ",  encode = FALSE)
					if(new_name)
						new_name = reject_bad_name(new_name)
						if(new_name)
							nickname = new_name
						else
							to_chat(user, "<font color='red'>Неверное прозвище. Длина прозвища должна быть не менее 2 и не более [MAX_NAME_LEN] символов. Оно может содержать только символы A-Z, a-z, -, ', . and ,.</font>")

				if("subclassoutfit")
					var/list/choices = list("None")
					var/datum/job/highest_pref
					for(var/job in job_preferences)
						if(job_preferences[job] > highest_pref)
							highest_pref = SSjob.GetJob(job)
					if(isnull(highest_pref))
						to_chat(user, "<b>I don't have a Class set to High!</b>")
					if(length(highest_pref.job_subclasses))
						for(var/adv in highest_pref.job_subclasses)
							var/datum/advclass/advpath = adv
							var/datum/advclass/advref = SSrole_class_handler.get_advclass_by_name(initial(advpath.name))
							choices[advref.name] = advref
					if(length(choices))
						var/new_choice = input(user, "Choose an outfit preview:", "Outfit Preview")  as anything in choices|null
						if(new_choice && new_choice != "None")
							preview_subclass = choices[new_choice]
							update_preview_icon()
						else
							preview_subclass = null
							update_preview_icon(jobOnly = TRUE)

//				if("age")
//					var/new_age = input(user, "Choose your character's age:\n([AGE_MIN]-[AGE_MAX])", "Years Dead") as num|null
//					if(new_age)
//						age = max(min( round(text2num(new_age)), AGE_MAX),AGE_MIN)

				if("age")
					var/new_age = tgui_input_list(user, "Выберите возрастной этап персонажа (в рамках 18-[pref_species.max_age] лет)", "ПРОЖИТЫЕ ГОДЫ", pref_species.possible_ages) 
					if(new_age)
						age = new_age
						var/list/hairs
						if((age == AGE_OLD) && (OLDGREY in pref_species.species_traits))
							hairs = pref_species.get_oldhc_list()
						else
							hairs = pref_species.get_hairc_list()
						hair_color = hairs[pick(hairs)]
						facial_hair_color = hair_color
						// LETHALSTONE EDIT: let players know what this shit does stats-wise
						switch (age)
							if (AGE_ADULT)
								to_chat(user, "Вы проживаете свои лучшие годы, какими бы они ни были, не получая никаких преимуществ и не терпя никаких ограничений за свою короткую жизнь в этом мире.")
							if (AGE_MIDDLEAGED)
								to_chat(user, "Мышцы болят, а суставы стираются, когда хватка времени сжимает ваши плечи. (-1 SPD, +1 WIL)")
							if (AGE_OLD)
								to_chat(user, "В таком опасном мире, как ПСАЙДОНИЯ, пожилые люди — почти чудо... Или бенефициары родовых привилегий. (-1 STR, -2 SPE, -1 PER, -2 CON, +2 INT, +1 FOR)")
						// LETHALSTONE EDIT END
						ResetJobs()
						to_chat(user, "<font color='red'>Классы сброшены.</font>")

				// LETHALSTONE EDIT: add statpack selection
				if ("statpack")
					var/list/statpacks_available = list()
					for (var/path as anything in GLOB.statpacks)
						var/datum/statpack/statpack = GLOB.statpacks[path]
						if (!statpack.name)
							continue
						var/index = statpack.name
						if(length(statpack.stat_array))
							index += " \n[statpack.generate_modifier_string()]"
						statpacks_available[index] = statpack

					statpacks_available = sort_list(statpacks_available)

					var/statpack_input = tgui_input_list(user, "Как проявляются ваши качества?", "АТРИБУТЫ", statpacks_available, statpack)
					if (statpack_input)
						var/datum/statpack/statpack_chosen = statpacks_available[statpack_input]
						statpack = statpack_chosen
						to_chat(user, "<font color='purple'>[statpack.name]</font>")
						to_chat(user, "<font color='purple'>[statpack.description_string()]</font>")
						/* also, unset our virtue if we're not a virtuous statpack.
						if (!istype(statpack, /datum/statpack/wildcard/virtuous) && virtue.type != /datum/virtue/none)
							virtue = new /datum/virtue/none
							to_chat(user, span_info("Ваша добродетель была удалена из-за принятия взаимоисключающего набора атрибутов.")) */
				// LETHALSTONE EDIT: add pronouns
				if ("pronouns")
					var pronouns_input = tgui_input_list(user, "Выберите местоимения вашего персонажа", "МЕСТОИМЕНИЯ", GLOB.pronouns_list)
					if(pronouns_input)
						pronouns = pronouns_input
						ResetJobs()
						to_chat(user, "<font color='red'>Местоимения вашего персонажа теперь [pronouns].</font>")
						to_chat(user, "<font color='red'><b>Ваши классы были сброшены.</b></font>")

				// LETHALSTONE EDIT: add voice type selection
				if ("voicetype")
					var voicetype_input = tgui_input_list(user, "Выберите тип голоса для персонажа", "ТИП ГОЛОСА", GLOB.voice_types_list) 
					if(voicetype_input)
						voice_type = voicetype_input
						to_chat(user, "<font color='red'>Ваш персонаж теперь будет звучать как [lowertext(voice_type)] affect.</font>")

				if("taur_type")
					var/list/species_taur_list = pref_species.get_taur_list()
					if(!LAZYLEN(species_taur_list))
						taur_type = null
						to_chat(user, span_bad("Для этого вида нет звериных частей тела."))
						return

					var/list/taur_selection = list("None")
					for(var/obj/item/bodypart/taur/tt as anything in pref_species.get_taur_list())
						taur_selection[tt::name] = tt
					
					var/new_taur_type = tgui_input_list(user, "Выберите звериную часть персонажа", "ЗВЕРИНАЯ ПЛОТЬ", taur_selection)
					if(!new_taur_type)
						return

					if(new_taur_type == "None")
						taur_type = null
					else
						taur_type = taur_selection[new_taur_type]

					var/obj/item/bodypart/taur/tt = taur_type
					to_chat(user, span_red("Ваш персонаж теперь имеет [tt ? tt::name : "no taurtype."]."))

				if("faith")
					var/list/faiths_named = list()
					for(var/path as anything in GLOB.preference_faiths)
						var/datum/faith/faith = GLOB.faithlist[path]
						if(!faith.name)
							continue
						faiths_named[faith.name] = faith
					var/faith_input = tgui_input_list(user, "Мир разлагается. Во что тебе остаётся верить?", "ВЕРА", faiths_named) 
					if(faith_input)
						var/datum/faith/faith = faiths_named[faith_input]
						to_chat(user, "<font color='yellow'>Верование: [faith.translated_name]</font>") 				// ! REDMOON
						to_chat(user, "Описание: [faith.desc]") 												// ! REDMOON
						to_chat(user, "<font color='red'>Последователи: [faith.worshippers]</font>")			// ! REDMOON	
						selected_patron = GLOB.patronlist[faith.godhead] || GLOB.patronlist[pick(GLOB.patrons_by_faith[faith_input])]

				if("patron")
					var/list/patrons_named = list()
					for(var/path as anything in GLOB.patrons_by_faith[selected_patron?.associated_faith || initial(default_patron.associated_faith)])
						var/datum/patron/patron = GLOB.patronlist[path]
						if(!patron.name)
							continue
						patrons_named[patron.name] = patron
					var/god_input = tgui_input_list(user, "Главный среди множества", "ПОКРОВИТЕЛЬ", patrons_named)
					if(god_input)
						selected_patron = patrons_named[god_input]
						to_chat(user, "<font color='yellow'>Покровитель: [selected_patron]</font>")
						to_chat(user, "<font color='#FFA500'>Cфера покровительства: [selected_patron.domain]</font>")
						to_chat(user, "Предания: [selected_patron.desc]")
						to_chat(user, "<font color='red'>Типичные почитатели: [selected_patron.worshippers]</font>")

				if("combat_music") // if u change shit here look at /client/verb/combat_music() too
					if(!combat_music_helptext_shown)
						to_chat(user, span_notice("<span class='bold'>Боевая музыка</span>\n") + \
						"Варианты, отличные от \"Default\" заменяют музыку, что игра динамически выбирает, \
						исходя из твоего класса, статуса злодея или иных вещей.\n\
						Вы можете изменить это позже в \"Combat Mode Music\" во вкладке Options.")
						combat_music_helptext_shown = TRUE
					var/track_select = tgui_input_list(user, "Для вас в бою будет звучать это:", "МУЗЫКА В БОЮ", GLOB.cmode_tracks_by_name, combat_music?.name)
					if(track_select)
						combat_music = GLOB.cmode_tracks_by_name[track_select]
						to_chat(user, span_notice("Selected track: <b>[track_select]</b>."))
						if(combat_music.desc)
							to_chat(user, "<i>[combat_music.desc]</i>")
						if(combat_music.credits)
							to_chat(user, span_info("Song name: <b>[combat_music.credits]</b>"))

				if("bdetail")
					var/list/loly = list("Not yet.","Work in progress.","Don't click me.","Stop clicking this.","Nope.","Be patient.","Sooner or later.")
					to_chat(user, "<font color='red'>[pick(loly)]</font>")
					return

				if("voice")
					var/new_voice = input(user, "Выберите цвет голоса вашего персонажа:", "Настройки персонажа","#"+voice_color) as color|null
					if(new_voice)
						if(color_hex2num(new_voice) < 230)
							to_chat(user, "<font color='red'>Этот голос слишком тёмный для смертных.</font>")
							return
						voice_color = sanitize_hexcolor(new_voice)

				if("barksound")
					var/list/woof_woof = list()
					for(var/path in GLOB.bark_list)
						var/datum/bark/B = GLOB.bark_list[path]
						if(initial(B.ignore))
							continue
						if(initial(B.ckeys_allowed))
							var/list/allowed = initial(B.ckeys_allowed)
							if(!allowed.Find(user.client.ckey))
								continue
						woof_woof[initial(B.name)] = initial(B.id)
					var/new_bork = input(user, "Выберите желаемый возглас", "Настройки персонажа") as null|anything in woof_woof
					if(new_bork)
						bark_id = woof_woof[new_bork]
						var/datum/bark/B = GLOB.bark_list[bark_id] //Now we need sanitization to take into account bark-specific min/max values
						bark_speed = round(clamp(bark_speed, initial(B.minspeed), initial(B.maxspeed)), 1)
						bark_pitch = clamp(bark_pitch, initial(B.minpitch), initial(B.maxpitch))
						bark_variance = clamp(bark_variance, initial(B.minvariance), initial(B.maxvariance))

				if("barkspeed")
					var/datum/bark/B = GLOB.bark_list[bark_id]
					var/borkset = input(user, "Выберите желаемый темп возгласа (Большее — медленнее, меньше — быстрее). Min: [initial(B.minspeed)]. Max: [initial(B.maxspeed)]", "Настройки персонажа") as null|num
					if(!isnull(borkset))
						bark_speed = round(clamp(borkset, initial(B.minspeed), initial(B.maxspeed)), 1)

				if("barkpitch")
					var/datum/bark/B = GLOB.bark_list[bark_id]
					var/borkset = input(user, "Выберите высоту возгласа. Минимум: [initial(B.minpitch)]. Максимум: [initial(B.maxpitch)]", "Настройки персонажа") as null|num
					if(!isnull(borkset))
						bark_pitch = clamp(borkset, initial(B.minpitch), initial(B.maxpitch))

				if("barkvary")
					var/datum/bark/B = GLOB.bark_list[bark_id]
					var/borkset = input(user, "Выберите разброс в возгласах. Минимум: [initial(B.minvariance)]. Максимум: [initial(B.maxvariance)]", "Настройки персонажа") as null|num
					if(!isnull(borkset))
						bark_variance = clamp(borkset, initial(B.minvariance), initial(B.maxvariance))

				if("extra_language")
					var/static/list/selectable_languages = list(
						/datum/language/elvish,
						/datum/language/dwarvish,
						/datum/language/orcish,
						/datum/language/hellspeak,
						/datum/language/draconic,
						/datum/language/celestial,
						/datum/language/grenzelhoftian,
						/datum/language/kazengunese,
						/datum/language/etruscan,
						/datum/language/gronnic,
						/datum/language/otavan,
						/datum/language/aavnic
					)
					var/list/choices = list("None")
					for(var/language in selectable_languages)
						if(language in pref_species.languages)
							continue
						var/datum/language/a_language = new language()
						choices[a_language.name] = language

					var/chosen_language = tgui_input_list(user, "Можете выбрать язык, который персонаж знает помимо основных:", "ДОПОЛНИТЕЛЬНЫЙ ЯЗЫК", choices)
					if(chosen_language)
						if(chosen_language == "None")
							extra_language = "Выбрать"
						else
							extra_language = choices[chosen_language]

				if("voice_pitch")
					var/new_voice_pitch = tgui_input_number(user, "Выберите высоту голоса персонажа (от [MIN_VOICE_PITCH] до [MAX_VOICE_PITCH], чем меньше значение, тем голос ниже):", "Высота голоса", 1, 1.35, 0.8, round_value = FALSE)
					if(new_voice_pitch)
						if(new_voice_pitch < MIN_VOICE_PITCH || new_voice_pitch > MAX_VOICE_PITCH)
							to_chat(user, "<font color='red'>Value must be between [MIN_VOICE_PITCH] and [MAX_VOICE_PITCH].</font>")
							return
						voice_pitch = new_voice_pitch

				if("highlight_color")
					var/new_color = color_pick_sanitized(user, "Выберите цвет подсветки прозвища вашего персонажа:", "Настройки персонажа","#"+highlight_color)
					if(new_color)
						highlight_color = sanitize_hexcolor(new_color)

				if("headshot")
					to_chat(user, "<span class='notice'>Пожалуйста, используйте неэротические изображение области головы и плеч, чтобы сохранить погружение. ["<span class='bold'>Не используйте реальные фотографии или шуточные изображения.</span>"]</span>")
					to_chat(user, "<span class='notice'>Если фотография не отображается в игре должным образом, убедитесь, что это ссылка на изображение, которая корректно открывается в браузере.</span>")
					to_chat(user, "<span class='notice'>Имейте в виду, что фотография будет уменьшена до размера 325x325 пикселей, поэтому чем более квадратной будет картинка, тем лучше она будет выглядеть.</span>")
					var/new_headshot_link = tgui_input_text(user, "Вставьте ссылку на изображение (https, хосты: gyazo, e621, iBB.co):", "Портрет", headshot_link,  encode = FALSE)
					if(new_headshot_link == null)
						return
					if(new_headshot_link == "")
						headshot_link = null
						ShowChoices(user)
						return
					if(!valid_headshot_link(user, new_headshot_link))
						headshot_link = null
						ShowChoices(user)
						return
					headshot_link = new_headshot_link
					to_chat(user, "<span class='notice'>Картинка портрета успешно обновлена.</span>")
					log_game("[user] поставил(а) новую картинку портрета '[headshot_link]'.")
				if("legacyhelp")
					var/list/dat = list()
					dat += "Этот слот существовал ещё до крупных изменений описания / OOC.<br>"
					dat += "В связи с этим ему предоставили исключение что позволяет сохранить старую верстку и форматирование профиля, включая HTML.<br>"
					dat += "Если вы хотите оставить все как есть, <b>не редактируйте его.</b><br><br>"
					dat += "ЛЮБЫЕ изменения (Даже нажатие кнопки «ОК» на неизменённом описании/OOC заметках) <font color ='red'><b>необратимо</b></font> переопределить весь HTML и удалить устаревший статус слота.<br>"
					dat += "Никаких исключений. Развлекайтесь!"
					dat += "(Вы всё ещё можете добавить дополнительное OOC)"
					var/datum/browser/popup = new(user, "Legacy Help", nwidth = 450, nheight = 250)
					popup.set_content(dat.Join())
					popup.open(FALSE)
				if("formathelp")
					var/list/dat = list()
					dat +="Вы можете использовать слэш (\\) чтобы избежать избежать активации специальных символов, приведённых ниже:<br>"
					dat += "<br>"
					dat += "# текст : Определяет заголовок.<br>"
					dat += "|текст| : Центрирует текст.<br>"
					dat += "**текст** : Делает текст <b>жирным</b>.<br>"
					dat += "*текс* : Делает текст <i>курсивным</i>.<br>"
					dat += "^текст^ : Увеличивает <font size = \"4\">размер</font> текста.<br>"
					dat += "((текст)) : Уменьшает <font size = \"1\">размер</font> текста.<br>"
					dat += "* item : Пункт неупорядоченного списка.<br>"
					dat += "--- : Добавляет горизонтальную линию.<br>"
					dat += "-=FFFFFFtext=- : Добавляет специальный <font color = '#FFFFFF'>цвет</font> тексту.<br><br>"
					dat += "Минимальное описание персонажа: <b>[MINIMUM_FLAVOR_TEXT]</b> символов.<br>"
					dat += "Минимальный размер OOC заметок: <b>[MINIMUM_OOC_NOTES]</b> символов."
					var/datum/browser/popup = new(user, "Formatting Help", nwidth = 400, nheight = 350)
					popup.set_content(dat.Join())
					popup.open(FALSE)
				if("flavortext")
					to_chat(user, "<span class='notice'>["<span class='bold'>Описание не должно содержать ничего нематериального и недоступного восприятию других, например, предысторию или мысли персонажа.</span>"]</span>")
					var/new_flavortext = tgui_input_text(user, "Введите описание вашего персонажа:", "Описание", flavortext, multiline = TRUE,  encode = FALSE, bigmodal = TRUE)
					if(new_flavortext == null)
						return
					if(new_flavortext == "")
						flavortext = null
						ShowChoices(user)
						return
					flavortext = new_flavortext
					to_chat(user, "<span class='notice'>Описание успешно обновлено</span>")
					log_game("[user] установил/а своё описание'.")
				if("ooc_notes")
					to_chat(user, "<span class='notice'>["<span class='bold'>OOC заметки - внеигровые. Их следует использовать для обозначения ожиданий от игры в целом и общей информации о вашем подходе к отыгрышу, притязаниях к персонажам и т.д.</span>"]</span>")
					var/new_ooc_notes = tgui_input_text(user, "Введите ваши OOC примечания:", "OOC заметки", ooc_notes, multiline = TRUE,  encode = FALSE, bigmodal = TRUE)
					if(new_ooc_notes == null)
						return
					if(new_ooc_notes == "")
						ooc_notes = null
						ShowChoices(user)
						return
					ooc_notes = new_ooc_notes
					to_chat(user, "<span class='notice'>ООС заметки успешно обновлены.</span>")
					log_game("[user] установил/а свои OOC заметки'.")
				if("nsfwflavortext")
					to_chat(user, "<span class='notice'>["<span class='bold'>Откровенное описание можно использовать для описания голого тела и других деталей, которые могут быть сочтены пикантными.</span>"]</span>")
					to_chat(user, "<font color = '#d6d6d6'>Оставьте пустым, чтобы очистить.</font>")
					var/new_nsfwflavortext = tgui_input_text(user, "Введите описание вашего персонажа:", "Откровенное описание", nsfwflavortext, multiline = TRUE,  encode = FALSE, bigmodal = TRUE)
					if(new_nsfwflavortext == null)
						return
					if(new_nsfwflavortext == "")
						new_nsfwflavortext = null
						nsfwflavortext = null
						to_chat(user, "<span class='notice'>Откровенное описание успешно удалено.</span>")
						ShowChoices(user)
						return
					nsfwflavortext = new_nsfwflavortext
					to_chat(user, "<span class='notice'>Откровенное описание успешно обновлено</span>")
					log_game("[user] установил(а) своё откровенное описание'.")
				if("erpprefs")
					to_chat(user, "<span class='notice'>["<span class='bold'>Вкусы в эротическом отыгрыше. Если вы укажете здесь «всё разрешено» или «делайте что хотите», то не жалуйтесь, если люди воспользуются этим.</span>"]</span>")
					to_chat(user, "<font color = '#d6d6d6'>Оставьте пустым, чтобы очистить.</font>")
					var/new_erpprefs = tgui_input_text(user, "Напишите свои предпочтения:", "ERP пристрастия", erpprefs, multiline = TRUE,  encode = FALSE, bigmodal = TRUE)
					if(new_erpprefs == null)
						return
					if(new_erpprefs == "")
						new_erpprefs = null
						erpprefs = null
						to_chat(user, "<span class='notice'>ERP пристрастия успешно удалены.</span>")
						ShowChoices(user)
						return
					erpprefs = new_erpprefs
					to_chat(user, "<span class='notice'>ЕRP пристрастия успешно обновлены.</span>")
					log_game("[user] установил(а) свои EPR пристрастия'.")

				if("img_gallery")

					if(img_gallery.len >= 3)
						to_chat(user, "У вас уже есть три изображения в галерее!")
						return

					to_chat(user, "<span class='notice'>Пожалуйста, не используйте эротические изображения ["<span class='bold'>вашего персонажа</span>"] для поддержания погружения. Напоследок, ["<span class='bold'>не используйте реальные фотографии или шуточные изображения.</span>"]</span>")
					to_chat(user, "<span class='notice'>Если фотография не отображается в игре должным образом, убедитесь, что это прямая ссылка на изображение, которая корректно открывается в браузере.</span>")
					to_chat(user, "<span class='notice'>Имейте в виду, что все три изображения отображаются рядом друг с другом и выравниваются по горизонтали, заполняя прямоугольник. Поэтому вертикальные изображения работают лучше всего.</span>")
					to_chat(user, "<span class='notice'>У вас может быть не больше ["<span class='bold'>ТРЁХ ИЗОБРАЖЕНИЙ</span>"] в галерее.</span>")
					
					var/new_galleryimg = tgui_input_text(user, "Вставьте ссылку на изображение (https, хосты: gyazo, e621, iBB.co):", "Галерея изображений",  encode = FALSE)

					if(new_galleryimg == null)
						return
					if(new_galleryimg == "")
						new_galleryimg = null
						ShowChoices(user)
						return
					if(!valid_headshot_link(user, new_galleryimg))
						to_chat(user, "<span class='notice'>Недействительная ссылка на изображение. Убедитесь, что это прямая ссылка с корректного хостинга. (gyazo, e621, iBB.co).</span>")
						new_galleryimg = null
						ShowChoices(user)
						return
					img_gallery += new_galleryimg
					to_chat(user, "<span class='notice'>Изображение успешно добавлено в галерею.</span>")
					log_game("[user] добавил/а изображение в галерею: '[new_galleryimg]'.")

				if("clear_gallery")
					if(!img_gallery.len)
						to_chat(user, "В вашей галерее нет изображений для очистки!")
						return
					var/dachoice = tgui_alert(user, "Вы действительно хотите очистить свою галерею изображений?", "Очистить галерею", list("Да", "Неа"))
					if(dachoice == "Nae")
						ShowChoices(user)
						return
					img_gallery = list()
					to_chat(user, "<span class='notice'>Галерея изображений успешно очищена.</span>")
					log_game("[user] очистил(а) свою галерею изображений.")

				if("ooc_preview")
					var/datum/examine_panel/preview_examine_panel = new(user)
					preview_examine_panel.pref = src
					preview_examine_panel.holder = user
					preview_examine_panel.viewing = user
					preview_examine_panel.ui_interact(user)

				if("ooc_extra")
					to_chat(user, "<span class='notice'>Добавьте ссылку с подходящего хоста (catbox, etc) в mp3 файле для вставки в ваше описание.</span>")
					to_chat(user, "<span class='notice'>Если песня не воспроизводится должным образом, убедитесь, что это прямая ссылка, которая корректно открывается в браузере.</span>")
					to_chat(user, "<font color = '#d6d6d6'>Оставьте поле пустым, чтобы удалить текущую песню.</font>")
					to_chat(user, "<font color ='red'>Злоупотребление этим приведет к наказанию.</font>")
					var/new_extra_link = tgui_input_text(user, "Введите поддерживаемую ссылку (https, хосты: discord, catbox):", "URL песни", ooc_extra, encode = FALSE)
					if(new_extra_link == null)
						return
					if(new_extra_link == "")
						new_extra_link = null
						ooc_extra = null
						to_chat(user, "<span class='notice'>Дополнительные OOC успешно удалены.</span>")
						ShowChoices(user)
						return
					var/static/list/valid_extensions = list("mp3")
					if(!valid_headshot_link(user, new_extra_link, FALSE, valid_extensions))
						new_extra_link = null
						ShowChoices(user)
						return

					var/list/value_split = splittext(new_extra_link, ".")

					// extension will always be the last entry
					var/extension = value_split[length(value_split)]
					if((extension in valid_extensions))
						ooc_extra = new_extra_link
						to_chat(user, "<span class='notice'>Ссылка на песню успешно удалена.</span>")
						log_game("[user] установил(а) ссылку песни на '[ooc_extra]'.")

				if("change_artist")
					var/new_artist = tgui_input_text(user, "Введите исполнителя вашей песни:", "Исполнитель песни", song_artist,  encode = FALSE)
					if(new_artist == null)
						return
					if(new_artist == "")
						ShowChoices(user)
						return
					song_artist = new_artist
					to_chat(user, "<span class='notice'>Исполнитель песни успешно обновлен.</span>")
					log_game("[user] установил(а) исполнителя песни.")

				if("change_title")
					var/new_title = tgui_input_text(user, "Введите название вашей песни:", "Название песни", song_title,  encode = FALSE)
					if(new_title== null)
						return
					if(new_title == "")
						ShowChoices(user)
						return
					song_title = new_title
					to_chat(user, "<span class='notice'>Название песни успешно обновлено.</span>")
					log_game("[user] обновила/а своё название песни.")

				if("familiar_prefs")
					familiar_prefs.fam_show_ui()

				if("loadout_item")
					var/list/loadouts_available = list("None")
					for (var/path as anything in GLOB.loadout_items)
						var/datum/loadout_item/loadout = GLOB.loadout_items[path]
						var/donoritem = loadout.donoritem
						if(donoritem && !loadout.donator_ckey_check(user.ckey))
							continue
						if (!loadout.name)
							continue
						loadouts_available[loadout.name] = loadout

					var/loadout_input = tgui_input_list(user, "Выберите персональные предметы персонажа, не зависящие от его класса. Вы не появляетесь с этим! Чтобы забрать их, нажмите ПКМ на дерево, статую или часы!!!", "Личная вещь I", loadouts_available) 
					if(loadout_input)
						if(loadout_input == "None")
							loadout = null
							to_chat(user, "Да кому это нужно..")
						else
							loadout = loadouts_available[loadout_input]
							to_chat(user, "<font color='yellow'><b>[loadout.name]</b></font>")
							if(loadout.desc)
								to_chat(user, "[loadout.desc]")
				if("loadout_item2")
					var/list/loadouts_available = list("None")
					for (var/path as anything in GLOB.loadout_items)
						var/datum/loadout_item/loadout2 = GLOB.loadout_items[path]
						var/donoritem = loadout2.donoritem
						if(donoritem && !loadout2.donator_ckey_check(user.ckey))
							continue
						if (!loadout2.name)
							continue
						loadouts_available[loadout2.name] = loadout2

					var/loadout_input2 = tgui_input_list(user, "Выберите персональные предметы персонажа, не зависящие от его класса. Вы не появляетесь с этим! Чтобы забрать их, нажмите ПКМ на дерево, статую или часы!!!", "Личная вещь II", loadouts_available) 
					if(loadout_input2)
						if(loadout_input2 == "None")
							loadout2 = null
							to_chat(user, "Да кому это нужно..")
						else
							loadout2 = loadouts_available[loadout_input2]
							to_chat(user, "<font color='yellow'><b>[loadout2.name]</b></font>")
							if(loadout2.desc)
								to_chat(user, "[loadout2.desc]")
				if("loadout_item3")
					var/list/loadouts_available = list("None")
					for (var/path as anything in GLOB.loadout_items)
						var/datum/loadout_item/loadout3 = GLOB.loadout_items[path]
						var/donoritem = loadout3.donoritem
						if(donoritem && !loadout3.donator_ckey_check(user.ckey))
							continue
						if (!loadout3.name)
							continue
						loadouts_available[loadout3.name] = loadout3

					var/loadout_input3 = tgui_input_list(user, "Выберите персональные предметы персонажа, не зависящие от его класса. Вы не появляетесь с этим! Чтобы забрать их, нажмите ПКМ на дерево, статую или часы!!!", "Личная вещь III", loadouts_available) 
					if(loadout_input3)
						if(loadout_input3 == "None")
							loadout3 = null
							to_chat(user, "Да кому это нужно..")
						else
							loadout3 = loadouts_available[loadout_input3]
							to_chat(user, "<font color='yellow'><b>[loadout3.name]</b></font>")
							if(loadout3.desc)
								to_chat(user, "[loadout3.desc]")
				if("species")
					var/list/species = list()
					for(var/A in GLOB.roundstart_races)
						var/datum/species/race = GLOB.species_list[A]
						race = new race()
						if(user.client)
							if(race.patreon_req > user.client.patreonlevel())
								continue
						else
							continue
						species += race

					species = sortNames(species)

					var/result = tgui_input_list(user, "Какой из обликов - темница ваша?", "НАРОДНОСТИ", species)

					if(result)
						set_new_race(result, user)

				if("update_mutant_colors")
					update_mutant_colors = !update_mutant_colors

				if("dnr")
					dnr_pref = !dnr_pref

				if("virtue")
					var/list/virtue_choices = list()
					for (var/path as anything in GLOB.virtues)
						var/datum/virtue/V = GLOB.virtues[path]
						if (!V.name)
							continue
						if ((V.name == virtue.name || V.name == virtuetwo.name) && !istype(V, /datum/virtue/none))
							continue
						if (istype(V, /datum/virtue/heretic) && !istype(selected_patron, /datum/patron/inhumen))
							continue
						if(length(pref_species.restricted_virtues) && (V.type in pref_species.restricted_virtues))
							continue
						virtue_choices[V.name] = V
					virtue_choices = sort_list(virtue_choices)
					var/result = tgui_input_list(user, "Каким преимуществом вы обладаете?", "ДОСТОИНСТВА",virtue_choices)

					if (result)
						var/datum/virtue/virtue_chosen = virtue_choices[result]
						virtue = virtue_chosen
						to_chat(user, process_virtue_text(virtue_chosen))

				if("virtuetwo")
					var/list/virtue_choices = list()
					for (var/path as anything in GLOB.virtues)
						var/datum/virtue/V = GLOB.virtues[path]
						if (!V.name)
							continue
						if ((V.name == virtue.name || V.name == virtuetwo.name) && !istype(V, /datum/virtue/none))
							continue
						if(length(pref_species.restricted_virtues) && (V.type in pref_species.restricted_virtues))
							continue
						if (istype(V, /datum/virtue/heretic) && !istype(selected_patron, /datum/patron/inhumen))
							continue
						virtue_choices[V.name] = V
					virtue_choices = sort_list(virtue_choices)
					var/result = tgui_input_list(user, "Какую силу ты будешь использовать?", "ДОСТОИНСТВА",virtue_choices)

					if (result)
						var/datum/virtue/virtue_chosen = virtue_choices[result]
						virtuetwo = virtue_chosen
						to_chat(user, process_virtue_text(virtue_chosen))
					/*	if (statpack.type != /datum/statpack/wildcard/virtuous)
							statpack = new /datum/statpack/wildcard/virtuous
							to_chat(user, span_purple("Ваш набор атрибутов изменён на «Чистый» (ничего не получаете) из-за выбора достоиснтва.")) */

				if("charflaw")
					var/list/coom = GLOB.character_flaws.Copy()
					var/result = tgui_input_list(user, "Что станет вашим бременем?", "НЕДОСТАТКИ",coom)
					if(result)
						result = coom[result]
						var/datum/charflaw/C = new result()
						charflaw = C
						if(charflaw.desc)
							to_chat(user, "<span class='info'>[charflaw.desc]</span>")

				if("race_bonus_select")
					if(length(pref_species.custom_selection))
						var/choice = tgui_input_list(user, "Чем судьба благословила ваш народ?", "БОНУС", pref_species.custom_selection)
						if(choice)
							race_bonus = pref_species.custom_selection[choice]

				if("body_size")
					var/new_body_size = tgui_input_number(user, "Выберите желаемый размер модельки:\n([BODY_SIZE_MIN*100]%-[BODY_SIZE_MAX*100]%), Предупреждение: ваш персонаж может выглядеть искаженным.", "Настройки персонажа", features["body_size"]*100)
					if(new_body_size)
						new_body_size = clamp(new_body_size * 0.01, BODY_SIZE_MIN, BODY_SIZE_MAX)
						features["body_size"] = new_body_size

				if("taur_color")
					var/new_taur_color = color_pick_sanitized(user, "Выберите цвет звериной части:", "Настройки персонажа", "#"+taur_color)
					if(new_taur_color)
						taur_color = sanitize_hexcolor(new_taur_color)

				if("mutant_color")
					var/new_mutantcolor = color_pick_sanitized(user, "Выберите окрас #1:", "Настройки персонажа","#"+features["mcolor"])
					if(new_mutantcolor)

						features["mcolor"] = sanitize_hexcolor(new_mutantcolor)
						try_update_mutant_colors()

				if("mutant_color2")
					var/new_mutantcolor = color_pick_sanitized(user, "Выберите окрас #2:", "Настройки персонажа","#"+features["mcolor2"])
					if(new_mutantcolor)
						features["mcolor2"] = sanitize_hexcolor(new_mutantcolor)
						try_update_mutant_colors()

				if("mutant_color3")
					var/new_mutantcolor = color_pick_sanitized(user, "Выберите окрас #3:", "Настройки персонажа","#"+features["mcolor3"])
					if(new_mutantcolor)
						features["mcolor3"] = sanitize_hexcolor(new_mutantcolor)
						try_update_mutant_colors()

/*
				if("color_ethereal")
					var/new_etherealcolor = input(user, "Choose your ethereal color", "Настройки персонажа") as null|anything in GLOB.color_list_ethereal
					if(new_etherealcolor)
						features["ethcolor"] = GLOB.color_list_ethereal[new_etherealcolor]

				if("legs")
					var/new_legs
					new_legs = input(user, "Выберите ноги вашего персонажа:", "Настройки персонажа") as null|anything in GLOB.legs_list
					if(new_legs)
						features["legs"] = new_legs
*/
				if("s_tone")
					var/listy = pref_species.get_skin_list()
					var/new_s_tone = tgui_input_list(user, "Выберите происхождение и цвет кожи персонажа:", "Племенная принадлежность", listy)
					if(new_s_tone)
						skin_tone = listy[new_s_tone]
						try_update_mutant_colors()

				if("charflaw")
					var/selectedflaw
					selectedflaw = tgui_input_list(user, "Выберите недостаток персонажа:", "НЕДОСТАТОК", GLOB.character_flaws) 
					if(selectedflaw)
						charflaw = GLOB.character_flaws[selectedflaw]
						charflaw = new charflaw()
						if(charflaw.desc)
							to_chat(user, span_info("[charflaw.desc]"))

				if("char_accent")
					var/selectedaccent = tgui_input_list(user, "Выберите акцент персонажа:", "Настройки персонажа", GLOB.character_accents)
					if(selectedaccent)
						char_accent = selectedaccent

				if("ooccolor")
					var/new_ooccolor = color_pick_sanitized(user, "Выберите ваш цвет ООС:", "Настройки персонажа",ooccolor)
					if(new_ooccolor)
						ooccolor = new_ooccolor

				if("asaycolor")
					var/new_asaycolor = color_pick_sanitized(user, "Выберите ваш цвет ASAY:", "Настройки персонажа",asaycolor)
					if(new_asaycolor)
						asaycolor = new_asaycolor

				if("bag")
					var/new_backpack = input(user, "Выберите тип вашей торбы:", "Character Preference")  as null|anything in GLOB.backpacklist
					if(new_backpack)
						backpack = new_backpack

				if("suit")
					if(jumpsuit_style == PREF_SUIT)
						jumpsuit_style = PREF_SUIT
					else
						jumpsuit_style = PREF_SUIT

				if("uplink_loc")
					var/new_loc = input(user, "Choose your character's traitor uplink spawn location:", "Character Preference") as null|anything in GLOB.uplink_spawn_loc_list
					if(new_loc)
						uplink_spawn_loc = new_loc

				if("ai_core_icon")
					var/ai_core_icon = input(user, "Choose your preferred AI core display screen:", "AI Core Display Screen Selection") as null|anything in GLOB.ai_core_display_screens
					if(ai_core_icon)
						preferred_ai_core_display = ai_core_icon

				if("sec_dept")
					var/department = input(user, "Choose your preferred security department:", "Security Departments") as null|anything in GLOB.security_depts_prefs
					if(department)
						prefered_security_department = department

				if ("preferred_map")
					var/maplist = list()
					var/default = "Default"
					if (config.defaultmap)
						default += " ([config.defaultmap.map_name])"
					for (var/M in config.maplist)
						var/datum/map_config/VM = config.maplist[M]
						if(!VM.votable)
							continue
						var/friendlyname = "[VM.map_name] "
						if (VM.voteweight <= 0)
							friendlyname += " (disabled)"
						maplist[friendlyname] = VM.map_name
					maplist[default] = null
					var/pickedmap = input(user, "Choose your preferred map. This will be used to help weight random map selection.", "Character Preference")  as null|anything in sortList(maplist)
					if (pickedmap)
						preferred_map = maplist[pickedmap]

				if ("clientfps")
					var/desiredfps = input(user, "Choose your desired fps. (0 = synced with server tick rate (currently:[world.fps]))", "Character Preference", clientfps)  as null|num
					if (!isnull(desiredfps))
						clientfps = desiredfps
						parent.fps = desiredfps
				if("ui")
					var/pickedui = input(user, "Choose your UI style.", "Character Preference", UI_style)  as null|anything in sortList(GLOB.available_ui_styles)
					if(pickedui)
						UI_style = "Rogue"
						if (parent && parent.mob && parent.mob.hud_used)
							parent.mob.hud_used.update_ui_style(ui_style2icon(UI_style))
				if("pda_style")
					var/pickedPDAStyle = input(user, "Choose your PDA style.", "Character Preference", pda_style)  as null|anything in GLOB.pda_styles
					if(pickedPDAStyle)
						pda_style = pickedPDAStyle
				if("pda_color")
					var/pickedPDAColor = input(user, "Choose your PDA Interface color.", "Character Preference", pda_color) as color|null
					if(pickedPDAColor)
						pda_color = pickedPDAColor

				if("phobia")
					var/phobiaType = input(user, "What are you scared of?", "Character Preference", phobia) as null|anything in SStraumas.phobia_types
					if(phobiaType)
						phobia = phobiaType

		else
			switch(href_list["preference"])
				if("publicity")
					if(unlock_content)
						toggles ^= MEMBER_PUBLIC
				if ("max_chat_length")
					var/desiredlength = input(user, "Choose the max character length of shown Runechat messages. Valid range is 1 to [CHAT_MESSAGE_MAX_LENGTH] (default: [initial(max_chat_length)]))", "Character Preference", max_chat_length)  as null|num
					if (!isnull(desiredlength))
						max_chat_length = clamp(desiredlength, 1, CHAT_MESSAGE_MAX_LENGTH)
				if("gender")
					var/pickedGender = "male"
					if(gender == "male")
						pickedGender = "female"
					if(pickedGender && pickedGender != gender)
						gender = pickedGender
						to_chat(user, "<font color='red'>У персонажа отныне [friendlyGenders[pickedGender]] телосложение.</font>")
						//random_character(gender)
					genderize_customizer_entries()
				if("domhand")
					if(domhand == 1)
						domhand = 2
					else
						domhand = 1
				if("family")
					var/list/loly = list("Not yet.","Work in progress.","Don't click me.","Stop clicking this.","Nope.","Be patient.","Sooner or later.")
					to_chat(user, "<font color='red'>[pick(loly)]</font>")
					return
				if("hotkeys")
					hotkeys = !hotkeys
					if(hotkeys)
						winset(user, null, "input.focus=true command=activeInput input.background-color=[COLOR_INPUT_ENABLED]  input.text-color = #EEEEEE")
					else
						winset(user, null, "input.focus=true command=activeInput input.background-color=[COLOR_INPUT_DISABLED]  input.text-color = #ad9eb4")

				if("keybindings_capture")
					var/datum/keybinding/kb = GLOB.keybindings_by_name[href_list["keybinding"]]
					var/old_key = href_list["old_key"]
					CaptureKeybinding(user, kb, old_key)
					return

				if("keybindings_set")
					var/kb_name = href_list["keybinding"]
					if(!kb_name)
						user << browse(null, "window=capturekeypress")
						ShowChoices(user, 3)
						return

					var/clear_key = text2num(href_list["clear_key"])
					var/old_key = href_list["old_key"]
					if(clear_key)
						if(key_bindings[old_key])
							key_bindings[old_key] -= kb_name
							if(!length(key_bindings[old_key]))
								key_bindings -= old_key
						user << browse(null, "window=capturekeypress")
						save_preferences()
						ShowChoices(user, 3)
						return

					var/new_key = uppertext(href_list["key"])
					var/AltMod = text2num(href_list["alt"]) ? "Alt" : ""
					var/CtrlMod = text2num(href_list["ctrl"]) ? "Ctrl" : ""
					var/ShiftMod = text2num(href_list["shift"]) ? "Shift" : ""
					var/numpad = text2num(href_list["numpad"]) ? "Numpad" : ""
					// var/key_code = text2num(href_list["key_code"])

					if(GLOB._kbMap[new_key])
						new_key = GLOB._kbMap[new_key]

					var/full_key
					switch(new_key)
						if("Alt")
							full_key = "[new_key][CtrlMod][ShiftMod]"
						if("Ctrl")
							full_key = "[AltMod][new_key][ShiftMod]"
						if("Shift")
							full_key = "[AltMod][CtrlMod][new_key]"
						else
							full_key = "[AltMod][CtrlMod][ShiftMod][numpad][new_key]"
					if(key_bindings[old_key])
						key_bindings[old_key] -= kb_name
						if(!length(key_bindings[old_key]))
							key_bindings -= old_key
					key_bindings[full_key] += list(kb_name)
					key_bindings[full_key] = sortList(key_bindings[full_key])

					user << browse(null, "window=capturekeypress")
					user.client.update_movement_keys()
					save_preferences()

				if("keybindings_reset")
					var/choice = tgalert(user, "Вы хотите сброс до 'обычных' или 'классических' горячих клавиш?", "Настройка сброса", "Обычные", "Классические", "Отмена")
					if(choice == "Отмена")
						ShowChoices(user)
						return
					hotkeys = (choice == "Обычные")
					key_bindings = (hotkeys) ? deepCopyList(GLOB.hotkey_keybinding_list_by_key) : deepCopyList(GLOB.classic_keybinding_list_by_key)
					user.client.update_movement_keys()
				if("chat_on_map")
					chat_on_map = !chat_on_map
				if("see_chat_non_mob")
					see_chat_non_mob = !see_chat_non_mob
				if("action_buttons")
					buttons_locked = !buttons_locked
				if("tgui_fancy")
					tgui_fancy = !tgui_fancy
				if("tgui_lock")
					tgui_lock = !tgui_lock
				if("tgui_theme")
					setTguiStyle()
				if("winflash")
					windowflashing = !windowflashing

				//here lies the badmins
				if("hear_adminhelps")
					user.client.toggleadminhelpsound()
				if("hear_prayers")
					user.client.toggle_prayer_sound()
				if("announce_login")
					user.client.toggleannouncelogin()
				if("combohud_lighting")
					toggles ^= COMBOHUD_LIGHTING
				if("toggle_radio_chatter")
					user.client.toggle_hear_radio()
				if("toggle_prayers")
					user.client.toggleprayers()
				if("toggle_deadmin_always")
					toggles ^= DEADMIN_ALWAYS
				if("toggle_deadmin_antag")
					toggles ^= DEADMIN_ANTAGONIST
				if("toggle_deadmin_head")
					toggles ^= DEADMIN_POSITION_HEAD


				if("be_special")
					var/be_special_type = href_list["be_special_type"]
					if(be_special_type in be_special)
						be_special -= be_special_type
					else
						be_special += be_special_type

				if("toggle_random")
					var/random_type = href_list["random_type"]
					if(randomise[random_type])
						randomise -= random_type
					else
						randomise[random_type] = TRUE

				if("hear_midis")
					toggles ^= SOUND_MIDI

				if("lobby_music")
					toggles ^= SOUND_LOBBY
					if((toggles & SOUND_LOBBY) && user.client && isnewplayer(user))
						user.client.playtitlemusic()
					else
						user.stop_sound_channel(CHANNEL_LOBBYMUSIC)

				if("ghost_ears")
					chat_toggles ^= CHAT_GHOSTEARS

				if("ghost_sight")
					chat_toggles ^= CHAT_GHOSTSIGHT

				if("ghost_whispers")
					chat_toggles ^= CHAT_GHOSTWHISPER

				if("ghost_radio")
					chat_toggles ^= CHAT_GHOSTRADIO

				if("ghost_pda")
					chat_toggles ^= CHAT_GHOSTPDA

				if("income_pings")
					chat_toggles ^= CHAT_BANKCARD

				if("pull_requests")
					chat_toggles ^= CHAT_PULLR

				if("allow_midround_antag")
					toggles ^= MIDROUND_ANTAG

				if("parallaxup")
					parallax = WRAP(parallax + 1, PARALLAX_INSANE, PARALLAX_DISABLE + 1)
					if (parent && parent.mob && parent.mob.hud_used)
						parent.mob.hud_used.update_parallax_pref(parent.mob)

				if("parallaxdown")
					parallax = WRAP(parallax - 1, PARALLAX_INSANE, PARALLAX_DISABLE + 1)
					if (parent && parent.mob && parent.mob.hud_used)
						parent.mob.hud_used.update_parallax_pref(parent.mob)

				if("ambientocclusion")
					ambientocclusion = !ambientocclusion
					if(parent && parent.screen && parent.screen.len)
						var/atom/movable/screen/plane_master/game_world/PM = locate(/atom/movable/screen/plane_master/game_world) in parent.screen
						PM.backdrop(parent.mob)
						PM = locate(/atom/movable/screen/plane_master/game_world_fov_hidden) in parent.screen
						PM.backdrop(parent.mob)
						PM = locate(/atom/movable/screen/plane_master/game_world_above) in parent.screen
						PM.backdrop(parent.mob)

				if("auto_fit_viewport")
					auto_fit_viewport = !auto_fit_viewport
					if(auto_fit_viewport && parent)
						parent.fit_viewport()

				if("widescreenpref")
					widescreenpref = !widescreenpref
					user.client.change_view(CONFIG_GET(string/default_view))

				if("be_defiant")
					defiant = !defiant
					if(defiant)
						to_chat(user, span_notice("Теперь вы будете сопротивляться, если кто-то захочет взять вас силой."))
					else
						to_chat(user, span_boldwarning("Вы полностью отдаётесь мраку этого мира, отказываясь от сопротивления людям, что домогаются до вас."))

				if("schizo_voice")
					toggles ^= SCHIZO_VOICE
					if(toggles & SCHIZO_VOICE)
						to_chat(user, "<span class='warning'>Теперь вы Глас.\n\
										Как Глас, вы будете получать медитации от новичков, спрашивающих о механиках игры и не только!\n\
										Глас хороший - глас божий. Вы будете вознаграждены PQ за качественные ответы на медитации, а за плохие - наказаны.</span>")
					else
						to_chat(user, span_warning("Вы теперь не Глас."))

				if("migrants")
					migrant.show_ui()
					return

				if("manifest")
					parent.view_actors_manifest()
					return

				if("observe")
					var/mob/dead/new_player/P = user
					P.make_me_an_observer()
					return

				if("finished")
					user << browse(null, "window=latechoices") //closes late choices window
					user << browse(null, "window=playersetup") //closes the player setup window
					user << browse(null, "window=preferences") //closes job selection
					user << browse(null, "window=mob_occupation")
					user << browse(null, "window=latechoices") //closes late job selection
					user << browse(null, "window=migration") // Closes migrant menu

					SStriumphs.remove_triumph_buy_menu(user.client)

					winshow(user, "preferencess_window", FALSE)
					user << browse(null, "window=preferences_browser")
					user << browse(null, "window=lobby_window")
					return

				if("barkpreview")
					if(SSticker.current_state == GAME_STATE_STARTUP) //Timers don't tick at all during game startup, so let's just give an error message
						to_chat(user, "<span class='warning'>Предпрослушивание возгласов не может воспроизводиться во время инициализации!</span>")
						return
					if(!COOLDOWN_FINISHED(src, bark_previewing))
						return
					if(!parent || !parent.mob)
						return
					COOLDOWN_START(src, bark_previewing, (5 SECONDS))
					var/atom/movable/barkbox = new(get_turf(parent.mob))
					barkbox.set_bark(bark_id)
					var/total_delay
					for(var/i in 1 to (round((32 / bark_speed)) + 1))
						addtimer(CALLBACK(barkbox, TYPE_PROC_REF(/atom/movable, bark), list(parent.mob), 7, 70, BARK_DO_VARY(bark_pitch, bark_variance)), total_delay)
						total_delay += rand(DS2TICKS(bark_speed/4), DS2TICKS(bark_speed/4) + DS2TICKS(bark_speed/4)) TICKS
					QDEL_IN(barkbox, total_delay)

				if("save")
					save_preferences()
					save_character()
					to_chat(user, span_notice("ПЕРСОНАЖ СОХРАНЁН."))

				if("load")
					load_preferences()
					load_character()

				if("changeslot")
					var/list/choices = list()
					if(path)
						var/savefile/S = new /savefile(path)
						if(S)
							for(var/i=1, i<=max_save_slots, i++)
								var/name
								S.cd = "/character[i]"
								S["real_name"] >> name
								if(!name)
									name = "Slot[i]"
								choices[name] = i
					var/choice = tgui_input_list(user, "ВЫБЕРИТЕ ГЕРОЯ","ПУНЦЕГРАД", choices)
					if(choice)
						choice = choices[choice]
						if(!load_character(choice))
							random_character(null, FALSE, FALSE)
							save_character()

				if("tab")
					if (href_list["tab"])
						current_tab = text2num(href_list["tab"])

	ShowChoices(user)
	return 1



/datum/preferences/proc/copy_to(mob/living/carbon/human/character, icon_updates = 1, roundstart_checks = TRUE, character_setup = FALSE, antagonist = FALSE)
	if(randomise[RANDOM_SPECIES] && !character_setup)
		random_species()

	if((randomise[RANDOM_BODY] || randomise[RANDOM_BODY_ANTAG] && antagonist) && !character_setup)
		slot_randomized = TRUE
		random_character(gender, antagonist)

	// Bandaid to undo no arm flaw prosthesis
	if(charflaw)
		var/obj/item/bodypart/O = character.get_bodypart(BODY_ZONE_R_ARM)
		if(O)
			O.drop_limb()
			qdel(O)
		O = character.get_bodypart(BODY_ZONE_L_ARM)
		if(O)
			O.drop_limb()
			qdel(O)
		character.regenerate_limb(BODY_ZONE_R_ARM)
		character.regenerate_limb(BODY_ZONE_L_ARM)

	var/datum/species/chosen_species
	chosen_species = pref_species.type
	if(!(pref_species.name in GLOB.roundstart_races))
		set_new_race(new /datum/species/human/northern)

		random_character(gender, FALSE, FALSE)
	if(parent)
		if(pref_species.patreon_req > parent.patreonlevel())
			set_new_race(new /datum/species/human/northern)
			random_character(gender, FALSE, FALSE)

	character.age = age
	character.dna.features = features.Copy()
	character.gender = gender
	character.set_species(chosen_species, icon_update = FALSE, pref_load = src)
	character.dna.update_body_size()

	if((randomise[RANDOM_NAME] || randomise[RANDOM_NAME_ANTAG] && antagonist) && !character_setup)
		slot_randomized = TRUE
		real_name = pref_species.random_name(gender)

	if(roundstart_checks)
		if(CONFIG_GET(flag/humans_need_surnames) && ((pref_species.id == "human") || (pref_species.id == "humen")))
			var/firstspace = findtext(real_name, " ")
			var/name_length = length(real_name)
			if(!firstspace)	//we need a surname
				real_name += " [pick(GLOB.last_names)]"
			else if(firstspace == name_length)
				real_name += "[pick(GLOB.last_names)]"

	if(real_name in GLOB.chosen_names)
		character.real_name = pref_species.random_name(gender)
	else
		character.real_name = real_name
	character.name = character.real_name

	character.domhand = domhand
	character.cmode_music_override = combat_music.musicpath
	character.cmode_music_override_name = combat_music.name
	character.highlight_color = highlight_color
	character.nickname = nickname

	character.eye_color = eye_color
	if(extra_language && extra_language != "None")
		character.grant_language(extra_language)
	character.voice_color = voice_color
	character.voice_pitch = voice_pitch
	var/obj/item/organ/eyes/organ_eyes = character.getorgan(/obj/item/organ/eyes)
	if(organ_eyes)
		if(!initial(organ_eyes.eye_color))
			organ_eyes.eye_color = eye_color
	character.hair_color = hair_color
	character.facial_hair_color = facial_hair_color
	character.skin_tone = skin_tone
	character.hairstyle = hairstyle
	character.facial_hairstyle = facial_hairstyle
	character.detail = detail
	character.set_patron(selected_patron)
	character.backpack = backpack

	character.jumpsuit_style = jumpsuit_style

	if(charflaw)
		character.charflaw = new charflaw.type()
		character.charflaw.on_mob_creation(character)

	character.dna.real_name = character.real_name

	character.headshot_link = headshot_link

	character.statpack = statpack

	character.flavortext = flavortext

	character.ooc_notes = ooc_notes

	character.nsfwflavortext = nsfwflavortext

	character.defiant = defiant // ! REDMOON
	character.set_bark(bark_id) // ! REDMOON
	character.vocal_speed = bark_speed // ! REDMOON
	character.vocal_pitch = bark_pitch // ! REDMOON
	character.vocal_pitch_range = bark_variance // ! REDMOON

	character.erpprefs = erpprefs

	character.img_gallery = img_gallery

	character.ooc_extra = ooc_extra

	character.song_title = song_title

	character.song_artist = song_artist
	// LETHALSTONE ADDITION BEGIN: additional customizations

	character.pronouns = pronouns
	character.voice_type = voice_type

	// LETHALSTONE ADDITION END

	if(parent)
		var/list/L = get_player_curses(parent.ckey)
		if(L)
			for(var/X in L)
				ADD_TRAIT(character, curse2trait(X), TRAIT_GENERIC)

	if(taur_type)
		character.Taurize(taur_type, "#[taur_color]")
	else if(character_setup)
		// This should only ever ~do~ anything for previews
		character.ensure_not_taur()

	if(icon_updates)
		character.update_body()
		character.update_hair()
		character.update_body_parts(redraw = TRUE)

	character.char_accent = char_accent

	if(culinary_preferences)
		apply_culinary_preferences(character)

/datum/preferences/proc/get_default_name(name_id)
	switch(name_id)
		if("human")
			return random_unique_name()
		if("ai")
			return pick(GLOB.ai_names)
		if("cyborg")
			return DEFAULT_CYBORG_NAME
		if("clown")
			return pick(GLOB.clown_names)
		if("mime")
			return pick(GLOB.mime_names)
		if("religion")
			return DEFAULT_RELIGION
		if("deity")
			return DEFAULT_DEITY
	return random_unique_name()

/datum/preferences/proc/ask_for_custom_name(mob/user,name_id)
	var/namedata = GLOB.preferences_custom_names[name_id]
	if(!namedata)
		return

	var/raw_name = input(user, "Выберите [namedata["qdesc"]] вашего персонажа:","Настройки персонажа") as text|null
	if(!raw_name)
		if(namedata["allow_null"])
			custom_names[name_id] = get_default_name(name_id)
		else
			return
	else
		var/sanitized_name = reject_bad_name(raw_name,namedata["allow_numbers"])
		if(!sanitized_name)
			to_chat(user, "<font color='red'>Неверное имя. Длина вашего имени должна быть не менее 2 и не более [MAX_NAME_LEN] символов. Оно может содержать только следующие символы: A-Z, a-z,[namedata["allow_numbers"] ? ",0-9," : ""] -, ' and .</font>")
			return
		else
			custom_names[name_id] = sanitized_name

/// Resets the client's keybindings. Asks them for which
/datum/preferences/proc/force_reset_keybindings()
	var/choice = tgalert(parent.mob, "Необходимо сбросить базовые горячие клавиши. Установленные вами останутся без изменений. Вы хотите сброс до 'обычных' или 'классических' (TG) горячих клавиш? Не выбирайте классические, если не знаете что это.", "Сброс горячих клавиш", "Обычные", "Классические")
	hotkeys = (choice != "Классические")
	force_reset_keybindings_direct(hotkeys)

/// Does the actual reset
/datum/preferences/proc/force_reset_keybindings_direct(hotkeys = TRUE)
	var/list/oldkeys = key_bindings
	key_bindings = (hotkeys) ? deepCopyList(GLOB.hotkey_keybinding_list_by_key) : deepCopyList(GLOB.classic_keybinding_list_by_key)

	for(var/key in oldkeys)
		if(!key_bindings[key])
			key_bindings[key] = oldkeys[key]
	parent?.ensure_keys_set(src)

/datum/preferences/proc/try_update_mutant_colors()
	if(update_mutant_colors)
		reset_body_marking_colors()
		reset_all_customizer_accessory_colors()

/proc/valid_headshot_link(mob/user, value, silent = FALSE, list/valid_extensions = list("jpg", "png", "jpeg"))
	var/static/link_regex = regex(@"i\.gyazo.com|.\.l3n\.co|images2\.imgbox\.com|thumbs2\.imgbox\.com|files\.catbox\.moe") //gyazo, discord, lensdump, imgbox, catbox

	if(!length(value))
		return FALSE

	var/find_index = findtext(value, "https://")
	if(find_index != 1)
		if(!silent)
			to_chat(user, "<span class='warning'>Ваша ссылка должна начитнаться на https!</span>")
		return FALSE

	if(!findtext(value, ".") || findtext(value, "<") || findtext(value, ">") || findtext(value, "]") || findtext(value, "\["))	//there is no link in the world that would ever need < or >
		if(!silent)
			to_chat(user, "<span class='warning'>Invalid link!</span>")
		return FALSE
	var/list/value_split = splittext(value, ".")

	// extension will always be the last entry
	var/extension = value_split[length(value_split)]
	if(!(extension in valid_extensions))
		if(!silent)
			to_chat(usr, "<span class='warning'>The link must be one of the following extensions: '[english_list(valid_extensions)]'</span>")
		return FALSE

	find_index = findtext(value, link_regex)
	if(find_index != 9)
		if(!silent)
			to_chat(usr, "<span class='warning'>Ссылка должна быть размещена на одном из следующих сайтов: 'Gyazo, Lensdump, Imgbox, Catbox'</span>")
		return FALSE
	return TRUE

/datum/preferences/proc/is_active_migrant()
	if(!migrant)
		return FALSE
	if(!migrant.active)
		return FALSE
	return TRUE

/datum/preferences/proc/process_virtue_text(datum/virtue/V)
	var/dat
	if(V.desc)
		dat += "<font size = 3>[span_purple(V.desc)]</font><br>"
	if(length(V.added_skills))
		dat += "<font color = '#a3e2ff'><font size = 3>Это достоинство добавляет следующие навыки: <br>"
		for(var/list/L in V.added_skills)
			var/name
			if(ispath(L[1],/datum/skill))
				var/datum/skill/S = L[1]
				name = initial(S.name)
			dat += "["\Roman[L[2]]"] level[L[2] > 1 ? "s" : ""] of <b>[name]</b>[L[3] ? ", up to <b>[SSskills.level_names_plain[L[3]]]</b>" : ""] <br>"
		dat += "</font>"
	if(length(V.added_traits))
		dat += "<font color = '#a3ffe0'><font size = 3>Это достоинство дарует следующие черты: <br>"
		for(var/TR in V.added_traits)
			dat += "[TR] — <font size = 2>[GLOB.roguetraits[TR]]</font><br>"
		dat += "</font>"
	if(length(V.added_stashed_items))
		dat += "<font color = '#eeffa3'><font size = 3>Это достоинство добавляет следующие предметы в ваш инвентарь: <br>"
		for(var/I in V.added_stashed_items)
			dat += "<i>[I]</i> <br>"
		dat += "</font>"
	if(V.custom_text)
		dat += "<font color = '#ffffff'><font size = 3>Это достоинство имеет особое поведение: <br>"
		dat += "[V.custom_text]"
		dat += "</font>"
	return dat
