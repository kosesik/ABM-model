;breed [ v-riches v-rich]
breed [ riches rich]
;breed [ middles middle]
breed [ poores poor]
;breed [ v-poores v-poor]

patches-own [
  value
  dist
]

turtles-own [
  wealth
  vision
  targetpatch
  metabolism
  random-walk
]

to setup
clear-all
reset-ticks
;resize-world -20 20 -20 20

create--patches2
create--turtles
  
end
 


; CREATE PATCHES

to create--patches1

random-seed 123
ask n-of
;  (0.001 * count patches)
  2
  patches
  [
    set value 100
    set pcolor red
  ]  
end  
  
  
to create--patches2
  
ask n-of 5 patches
  [
  set value 100
  ask n-of 20 other patches in-radius 5
    [
     set value random 10 + 70 
    ]
  ]
ask n-of 50 patches with [value = 0]
  [
  set value random 10 + 40
  ]    
ask patches with [value = 0]
  [
    set value random 10 + 10
  ]  
diffuse value 0.6
diffuse value 0.6
  
  ask patches
  [
    patch-recolor
  ]
  
end

  
to create--patches3
  
let rx1 random max-pxcor
let ry1 random max-pycor

let rx2 random max-pxcor
let ry2 random max-pycor 

ask patch rx1 ry1
  [set value 100]
 ask patch rx2 ry2
  [set value 100]

  ask patches with [value = 0] 
  [
  let rvalue1 max [value] of patches - distancexy rx1 ry1 * 2
  let rvalue2 max [value] of patches - distancexy rx2 ry2 * 2
    
  ifelse rvalue1 > rvalue2 
  [set value rvalue1]
  [set value rvalue2]
  ]
  
ask patches
  [
  patch-recolor
  ] 


  
  
end


; CREATE TURTLES
  
to create--turtles
create-riches round (number-of-turtles * (percent-riches / 100)) [
  set shape "person"
  set size 0.5
  set heading 0
  setxy random-xcor random-ycor
  set color red
  set vision 4
  ]

create-poores round (number-of-turtles * (1 - (percent-riches / 100))) [
  set shape "person"
  set size 0.5
  set heading 0
  setxy random-xcor random-ycor
  set color blue
  set vision 2
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


end


;  let my-list-of-agents []
;  set my-list-of-agents sort-by [[t1 t2] -> [who] of t1 < [who] of t2] turtles
;  foreach my-list-of-agents [ ag ->


to go
  while [ticks < 400]
  [
  ask turtles
  [
;      set heading heading + rotate 30 30
      move
      set wealth wealth - 50 + ([value] of patch-here ) ;wealth minus cost of living plus income from patch divided by 6
  ]

;  let patchset any? turtles-here
;  show patchset
  ask patches
  [
  if any? turtles-here [
  set value value - 5
      if value <= 0 [set value 0]
  patch-recolor
  ]
  ]
update-plots
    tick]
end



to-report rotate [rt-r rt-l]
  report random rt-r - random rt-l
end

to move
  if ticks mod 5 = 0 [
  let patchset not any? other turtles-here
  set patchset patches in-radius vision
;  ask patchset[set pcolor white]
;  ask patchset [print self]
  set patchset sort patchset
;  show patchset
;  show is-list? patchset
;  set patchset patch-set patchset
  let patchset-dist map [i -> [distance myself] of i] patchset
  ifelse breed = riches [let discounted-rate map [i -> 1 ^ i] patchset-dist][let discounted-rate map [i -> discount-rate ^ i] patchset-dist]
  let discounted-rate map [i -> discount-rate ^ i] patchset-dist
  let values map [i -> [value] of i] patchset
;  show values
;  show discounted-rate
  let discounted-value (map [[a b] -> a * b] discounted-rate values)

;  show patchset-dist
;  show discounted-rate
  show discounted-value
;  foreach patchset [i -> show [value] of i]

  let target-patch2 max discounted-value
  show target-patch2
  let target-position position max discounted-value discounted-value
  let target-patch item target-position patchset
  show target-position
  show patchset
  show target-patch
  set targetpatch target-patch
  move-to targetpatch


  ]

end



to patch-recolor
;    set pcolor green + value / 20
    set pcolor scale-color green value 0 100
end

to save
file-delete "data.txt"
file-open "data.txt"
 file-print ticks
  file-print [value] of patches
file-close
end
