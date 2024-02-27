clear all
timer clear
net install parallel, from(https://raw.github.com/gvegayon/parallel/stable/) replace
mata mata mlib index

*bootstrap
sysuse auto, clear

parallel initialize 4, f

*start timer
timer on 1

parallel bs, reps(10000): reg price c.weig##c.weigh foreign rep
timer off 1
timer list

*same process no parallel
sysuse auto, clear

timer on 2

bs, reps(10000) nodots: reg price c.weig##c.weigh foreign rep
timer off 2
timer list
timer clear


