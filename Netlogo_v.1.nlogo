;breed [ v-rich v-riches]
breed [ rich riches]
;breed [ middle middles]
;breed [ poor poores]
breed [ v-poor v-poores]

patches-own [
  value
  dist
]

turtles-own [
  wealth
  vision
  metabolism
  random-walk
]

to setup
random-seed 123
;resize-world -20 20 -20 20
clear-all
reset-ticks
ask n-of
;  (0.001 * count patches)
  2
  patches
  [
    set value 100
    set pcolor red
  ]
create-turtles number-of-turtles [
  set shape "person"
  set size 0.5
  set heading 0 
  setxy random-xcor random-ycor
  ifelse percent-riches > random 100 [
      set color red
      set vision random 3 + 4
      ]
      [
      set color blue
      set vision random 3 + 1
      ]
    ]

end

to spread
  let patchset patches with[ value = 100]
  ask patches[
    set dist [ distance myself] of patchset
;    set dist sum dist
    set dist log (sum dist) 2
  ]
let distset [dist] of patches
  ask patches[
  set dist ([dist] of self - min distset ) / (max distset - min distset )
  set value (100 - dist * 100)
  ]
  repeat 1[
  diffuse value 0.3
  ]
 ask patches[
;    set value value - random 6 + random 6
    patch-recolor
  ]

update-plots
end


;  let my-list-of-agents []
;  set my-list-of-agents sort-by [[t1 t2] -> [who] of t1 < [who] of t2] turtles
;  foreach my-list-of-agents [ ag ->


to go
    ask turtles[
      set heading [heading] of self + rotate 30 30
      move
  ]

tick
end



to-report rotate [rt-r rt-l]
  report random rt-r - random rt-l
end

to move
forward random 10;  let my-list-of-agents []
;  set my-list-of-agents sort-by [[t1 t2] -> [who] of t1 < [who] of t2] turtles
;  foreach my-list-of-agents [ ag ->
    ask turtles[
      set heading [heading] of self + rotate 30 30
  ]
;  ]  
end



to patch-recolor
    set pcolor green + value / 20
end
