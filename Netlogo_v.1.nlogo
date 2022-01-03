patches-own [value dist]

;to setup
;clear-all
;reset-ticks
;ask n-of (0.005 * count patches) patches
;  [
;    set value 100
;    set pcolor green + value / 33
;  ]
;  ask patches with [value != 100]
;  [
;    set value one-of [0 ]
;  set pcolor green + value / 33
;
;  ]
;end

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

end

;to spread
;  ask patches with [value != 100]
; [
;  let nr count patches with [value = 100] in-radius 15
;  set nr nr * 10 - random 20 + random 20
;  if nr > 100
;  [
;  set nr 100
;  ]
;  if nr < 0
;  [
;  set nr 0
;  ]
;
;
;  set value nr
;  set pcolor green + value / 33
;  ]
;end



to spread
  ask patches
 [
    let patchset patches with[ value = 100]
    set dist [ distance myself] of patchset
    set dist sum dist
    set dist log dist 2
;    set plabel precision dist 2
  ]
let distset [dist] of patches
  ask patches
[

    set dist ([dist] of self - min distset ) / (max distset - min distset )
;    set plabel precision dist 2
;
;;  let nr count patches with [value = 100] in-radius 15
;;    set nr ((nr * 10 ) + (50 - (dist * 50) ))
;;  if nr > 100
;;  [
;;  set nr 100
;;  ]
;;  if nr < 0
;;  [
;;  set nr 0
;;  ]
;;  ]
;
  set value (100 - dist * 100)
;  set value dist
  set pcolor green + value / 30
;    set plabel precision dist 2


  ]


end






;  set nr nr * 10 - random 20 + random 20
;  if nr > 100
;  [
;  set nr 100
;  ]
;  if nr < 0
;  [
;  set nr 0
;  ]
;
;
;  set value nr
;  set pcolor green + value / 33
;  ]
;end




to diff
  repeat 1
  [
    diffuse value 0.3

  ]
 ask patches
  [
;  set pcolor scale-color green value 0 100 + 2
    set value value
;    - random 6 + random 6
    set pcolor green + value / 20
;    set plabel precision value 2

  ]

update-plots
end







;to diff
;ask patches
;  [
;    let sum-neighbors sum [dist] of neighbors
;    set plabel precision sum-neighbors 1
;
;
;
;
;; ask patches
;;  [
;;;  set pcolor scale-color green value 0 100 + 2
;;    set value value
;;;    - random 6 + random 6
;;    set pcolor green + value / 33
;;;    set plabel round sum-neighbors
;
;  ]
;
;
;end
;
;
















to go


tick
end

;if ticks >= 600
;[
;  stop
;]
