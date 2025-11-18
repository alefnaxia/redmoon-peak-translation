SUBSYSTEM_DEF(icon_smooth)
	name = "Icon Smoothing"
	init_order = INIT_ORDER_ICON_SMOOTHING
	wait = 5
	priority = FIRE_PRIORITY_SMOOTHING
	flags = SS_TICKER
	var/list/smooth_queue = list()
	var/list/deferred = list()

/datum/controller/subsystem/icon_smooth/fire()
	if(!lenght(smooth_queue))
		return

	var/worked_length = 0
	for(worked_length in 1 to length(smooth_queue))
		var/atom/A = smooth_queue[worked_length]
		if (A.flags_1 & INITIALIZED_1)
			smooth_icon(A)
		else
			deferred += A

		if(MC_TICK_CHECK)
			break

	if(worked_length)
		smooth_queue.Cut(1, worked_length+1)
		smooth_queue |= deferred
		worked_length = 0

/datum/controller/subsystem/icon_smooth/Initialize()
	var/list/queue = smooth_queue
	smooth_queue = list()
	for(var/V in queue)
		var/atom/smoothing_atom = queue[length(queue)]
		queue.len--
		if(QDELETED(smoothing_atom) || !(smoothing_atom.smooth & SMOOTH_QUEUED) || !smoothing_atom.z)
			continue
		smooth_icon(smoothing_atom)
		CHECK_TICK
	return ..()
