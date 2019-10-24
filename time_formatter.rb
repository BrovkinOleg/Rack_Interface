class TimeFormatter

  attr_reader :time_format, :wrong_formats

  FORMATS = {
      'year' => ' %Y -', 'month' => ' %m -', 'day' => ' %d ',
      'hour' => ' %H :', 'minute' => ' %M :', 'second' => ' %S '
  }

  def initialize(params)
    @time_format = ''
    @wrong_formats = []
    set_time_output(params['format'].split(','))
  end

  def call
    Time.now.strftime(@time_format)
  end

  private

  def set_time_output(params)
    params.each do |format|
      if FORMATS[format]
        @time_format += FORMATS[format]
      else
        @wrong_formats << format
      end
    end
  end

end