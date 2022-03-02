# Welcome to Sonic Pi
use_bpm 120 # global bpm sets duration of 1 beat (sleep 1)

# this loop forces all live_loops synced to it to start at the 
# same time. this is helpful when adding new loops while others
# are already running
live_loop :bang do
  cue :bang
  sleep 8
end

# samples play in 0 time, so all spacing of notes is controlled 
# by sleep
live_loop :floor, sync: :bang do
  7.times do
    sample :drum_bass_hard
    sleep 1
  end
  
  8.times do |n|
    sample :drum_bass_hard, amp: 1.0 * (n + 1) / 8.0
    sleep 0.125
  end
end

live_loop :snare, sync: :bang do
  3.times do
    # 1
    sleep 1
    
    # 2
    sample :sn_dub 
    sleep 1
  end
  
  sleep 1.0
  sample :sn_dub
  sleep 0.25
  sample :sn_dub
  sleep 0.75
end

# no sleep needed because the loop pauses until the next bang
# sonic-pi yelled at me for trying to use , sync: :bang as an 
# option to live_loop.
live_loop :chd do
  sync :bang  
  synth :dark_ambience
  play chord(:C3, :minor), attack: 1, decay: 3
end