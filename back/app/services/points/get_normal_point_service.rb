class Points::GetNormalPointService
  def initialize(point_rate)
    @point_rate = point_rate
  end

  def call(...)
    cal_normal_point(...)
  end

  private

  def cal_normal_point(points)
    get_point = points * @point_rate
    get_point.floor # 小数点以下切り捨て
  end
end
