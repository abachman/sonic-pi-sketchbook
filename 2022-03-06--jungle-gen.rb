
use_bpm 128

hats  = %w(1010 1110 1011 1001)
snare = %w(0000 1001 0001)
bass  = %w(1011 0100 0110 0010)
bass32 = %w(11001110 00110011 10101100)


define :sampler do |track, trig, delay = 0.25|
  beat = choose(track)
  beat.chars.each do |c|
    if c == '1'
      trig.call
    end
    sleep delay
  end
end


live_loop :hats, sync: :bar do
  sampler hats, -> {
    sample :drum_cymbal_closed, amp: rand(0.4) + 0.6
  }
end

live_loop :snare, sync: :bar do
  sampler snare, -> {
    sample :elec_hi_snare, amp: rand() * 0.5 + 0.5
  }
end

live_loop :bd, sync: :bar do
  if rand(1.0) > 0.25
    sampler bass, -> {
      sample :bd_tek
    }
  else
    sampler bass32, -> {
      sample :bd_tek
    }, 0.125
  end
end

live_loop :bar do
  cue :bar
  sleep 4
end
