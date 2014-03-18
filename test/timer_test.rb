require 'test_helper'

require 'metriks/timer'

class TimerTest < Test::Unit::TestCase
  def setup
    @timer = Metriks::Timer.new
  end

  def teardown
    @timer.stop
  end

  def test_timer
    3.times do
      @timer.time do
        sleep 0.1
      end
    end

    assert_in_delta 0.1, @timer.mean, 0.01
    assert_in_delta 0.1, @timer.snapshot.median, 0.01
  end

  def test_timer_without_block
    t = @timer.time
    sleep 0.1
    t.stop

    assert_in_delta 0.1, @timer.mean, 0.01
  end

  def test_reportable_fields
    fields = [
      :count, :one_minute_rate, :five_minute_rate,
      :fifteen_minute_rate, :mean_rate,
      :min, :max, :mean, :stddev
    ]

    assert_equal fields, @timer.reportable_fields
  end
end
