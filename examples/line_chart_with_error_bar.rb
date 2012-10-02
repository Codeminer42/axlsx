require 'rubygems'
require 'axlsx'

p = Axlsx::Package.new
wb = p.workbook

wb.add_worksheet(:name => "Line Chart") do |sheet|
 sheet.add_row ['1', '2', '3', '4']
 sheet.add_row [1, 2, 3, '=sum(A2:C2)']
 sheet.add_chart(Axlsx::LineChart, :start_at => [0,2], :end_at => [5, 15], :title => "Chart") do |chart|
   serie = chart.add_series :data => sheet["A2:D2"], :labels => sheet["A1:D1"], :title => 'bob'
   serie.error_y = {lower: "'Line Chart'!$A$2:$D$2", higher: "'Line Chart'!$A$2:$D$2"}
   chart.d_lbls.show_val = true
   chart.d_lbls.show_cat_name = true
   chart.catAxis.tick_lbl_pos = :none

 end
end

p.serialize('line_chart_with_error.xlsx')