module FormatData
extend ActiveSupport::Concern
  def format_unixtime_to_datetime(unixTime)
    epoch_time = unixTime.to_i / 1000 # ミリ秒から秒に変換
    datetime = Time.at(epoch_time).to_datetime
    datetime
  end
end