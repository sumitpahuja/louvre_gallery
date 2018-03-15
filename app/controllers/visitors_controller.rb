class VisitorsController < ApplicationController
  require 'csv'	
  def index
  end

  def import
  	main_hash = {}
    CSV.foreach(params[:file].path, headers: false, col_sep: "\s") do |row|
      next if row.count < 4	
      main_hash[row[1]] ||= {}
      main_hash[row[1]][row[0]] ||= {in: [], out: []}
      main_hash[row[1]][row[0]][:in] << row[3] if row[2] == 'I'
      main_hash[row[1]][row[0]][:out] << row[3] if row[2] == 'O'
    end
    @result = display_result(main_hash)
  end

  def time_spent_total(in_tm, out_tm)
    _in_times, _out_times = in_tm.sort, out_tm.sort
    return 0 if out_tm.count == 0
    _total_time_spent = 0 
    _out_times.each_with_index do |val, index|
      _total_time_spent += val.try(:to_i) - _in_times[index].try(:to_i)
    end
    return _total_time_spent
  end

  def display_result(visitors)
    _result = []
    visitors.each do |_outer_k,_outer_v|
      _count , _total_time_mins = 0, 0;
      _outer_v.each do | _inner_k, _inner_v|
        _count = _count + _inner_v[:out].count;
        _total_time_mins = _total_time_mins + time_spent_total(_inner_v[:in], _inner_v[:out])
      end
      _avg_time = _total_time_mins / _count; 
      _result << {room_id: _outer_k, avg_time: _avg_time, user_count: _count}
    end 
    _result
  end  
end
