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
      set vision 2
      ]
      [
      set color blue
      set vision 2
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
    set dist (dist - min distset ) / (max distset - min distset )
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
      set heading heading + rotate 30 30
      move
      set wealth wealth - 50 + [value] of patch-here ;wealth minus cost of living plus income from patch 
  ]
update-plots
tick
end



to-report rotate [rt-r rt-l]
  report random rt-r - random rt-l
end

to move
  let patchset patches in-radius vision
  ask patchset[set pcolor white]  
  ask patchset [print self]
  set patchset sort patchset
  show patchset
;  show is-list? patchset
;  set patchset patch-set patchset
  let patchset-dist map [i -> [distance myself] of i] patchset
  let discounted-rate map [i -> discount-rate ^ i] patchset-dist
  let values map [i -> [value] of i] patchset
  show values
  show discounted-rate
  let discounted-value (map [[a b] -> a * b] discounted-rate values)
  
  show patchset-dist
  show discounted-rate
  show discounted-value
  foreach patchset [i -> show [value] of i]
end



to patch-recolor
    set pcolor green + value / 20
end
