/datum/sex_action/tailjob
	name = "Use tail on their cock"
	check_same_tile = FALSE

/datum/sex_action/tailjob/shows_on_menu(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user == target)
		return FALSE
	if(!target.getorganslot(ORGAN_SLOT_PENIS))
		return FALSE
	if(!user.getorganslot(ORGAN_SLOT_TAIL))
		return FALSE
	return TRUE

/datum/sex_action/tailjob/can_perform(mob/living/carbon/human/user, mob/living/carbon/human/target)
	. = ..()
	if(!.)
		return FALSE
	if(user == target)
		return FALSE
	if(!check_location_accessible(user, target, BODY_ZONE_PRECISE_GROIN, TRUE))
		return FALSE
	if(!target.getorganslot(ORGAN_SLOT_PENIS))
		return FALSE
	if(!user.getorganslot(ORGAN_SLOT_TAIL))
		return FALSE
	return TRUE

/datum/sex_action/tailjob/on_start(mob/living/carbon/human/user, mob/living/carbon/human/target)
	..()
	user.visible_message(span_warning("[user] slides their tail around [target]'s cock..."))

/datum/sex_action/tailjob/on_perform(mob/living/carbon/human/user, mob/living/carbon/human/target)
	var/datum/sex_session/sex_session = get_sex_session(user, target)
	user.visible_message(sex_sessionspanify_force("[user] [user.sexcon.get_generic_force_adjective()] strokes [target]'s cock with their tail."))
	playsound(user, 'sound/misc/mat/fingering.ogg', 30, TRUE, -2, ignore_walls = FALSE)

	sex_session.perform_sex_action(target, 2, 0, TRUE)

	sex_session.handle_passive_ejaculation(user)

/datum/sex_action/tailjob/on_finish(mob/living/carbon/human/user, mob/living/carbon/human/target)
	..()
	user.visible_message(span_warning("[user] stops jerking [target]'s cock."))
