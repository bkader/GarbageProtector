# GarbageProtector

Some WoW addons call the lua collectgarbage function irresponsibly, causing all execution to halt until it is finished. This can take more than half a second, which freezes the game in an annoying manner. Most addons don't need to make such calls, but some do anyway, causing these lockups.

The addon's folder name has 3 "!"s at the beginning to cause it to be loaded first, before any addons that would slow loading screens with collectgarbage calls.


Warning: Due to the nature of the 2 hooks GarbageProtector implements, unless the hooks are toggled off (from either the GarbageProtector options menu, the command line interface, or the Lua setter functions), it will prevent:

1. Full manual garbage collection cycles (function named "collectgarbage"; does not prevent the regular rate of Lua's garbage collector)
2. Updating the current count of addon memory usage (function named "UpdateAddOnMemoryUsage"; makes profiling addons show 0 or their most recently-queried value)


For example, ElvUI has a feature to run a garbage collection manually by clicking somewhere. This is prevented by GarbageProtector because it is an irresponsible use of collectgarbage which locks up your game (which if run automatically like some addons do, is not nice to the user). However, if you really want to run it, you can toggle GarbageProtector's option with "/gp collectgarbage" or from the GUI options menu. That's why options were added in the first place: so you can choose what you want to do.
