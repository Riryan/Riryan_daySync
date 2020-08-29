# Riryan_daySync
Db stored time to sync all players in VORP-Core

This is the first release of my day_Sync.

###WARRING####
the code will need to be cleaned up. 
and better usage of qurries to the database. 

More Info:
it's currently set to a 1 to 1 ratio for the time steps.
its only affecting hour of the day at this time.

you can adjust how large of a time step by changing the TimeAdjustment 
since the Citizen.Wait() seems to have a limit when it comes to Server Side scripts. I've placed 3 60sec pauses 
giveing it a 3min time between Database updates in hopes of keeping the database from getting to overloaded on busy servers.
Which means leaving the TimeAdjustment = 3  will keep it to a minute to minute day cycle. Adjusting this to 6 will give you two game days per one real 
life day. ect ect. 

As it is now, no player will be more than 6mins apart on the time scale, which then sync them within 3 mins after logging on.
If you change the TimeAdjustment to 6, then a new player will be no more than 9mins apart on the time scale, but still be sync'd 
after 3 mins of play time.

I've added the command "updatetime" so the datebase can be changed at anytime
the args for this command is in mins, not hours
####Warrning 2####
for testing I've left the command open to anyone.



