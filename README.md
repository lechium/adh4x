# adh4x
Does it's best to hide and suppress annoying and creepy google advertisements on jailbroken iOS.

This takes a two pronged approach to removing annoying advertisements, it targets a few choice classes and hardcodes specific values to false and 0 as necessary, but it also adds a timer that fires every 30 seconds to make any views that derive from those choice classes and sets alpha to 0, user interaction to false and hidden to true. It's not fool proof and is kind of a POC / WIP. But i felt others would likely find it useful as well, so i thought i'd share it!
