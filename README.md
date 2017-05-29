# RaidHeroes-Parser
Script for automated ArcDPS EVTC log parsing of Guild Wars 2 via RaidHeroes.

This script is setup to parse logs files through [RaidHeroes](https://www.raidheroes.tk). Driving force behind the creation of this was to simply be lazy after raids to provide raid parses.
Currently setup to work with the naming scheme I chose ("MM-dd & MM-dd") housed in the local Dropbox directory. In the future I'll pull the paths to leave fillable if anyone wishes to use this.

The basis behind this is simply checking the last log made within each folder, grabbing it, parsing it through RaidHeroes.exe, move it, rename it. The complex  bits are checking existing folders within the Dropbox and comparing them to either (Get-Date) or (Get-Date).AddDays(-2), which are our two personal raid nights that logs would be created for our static team.

I'm sure most of this could be simplified greatly, but PowerShell is more or less a hobby that when I want to create a script I learn as I go using google or ss64.com/ps/ to learn how things work and how I can take what I want to do in my head and make it a reality through coding. Might be messy, but for now it works.

##### In the words of Ron Swanson:
![You know it to be true](http://i.imgur.com/HY10P2w.jpg)
