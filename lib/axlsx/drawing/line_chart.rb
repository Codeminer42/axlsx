# encoding: UTF-8
module Axlsx

  class LineChart < Chart

    attr_reader :catAxis, :valAxis, :serAxis, :gapDepth, :grouping

    # validation regex for gap amount percent
    GAP_AMOUNT_PERCENT = /0*(([0-9])|([1-9][0-9])|([1-4][0-9][0-9])|500)%/

    def initialize(frame, options={})
      @gapDepth = nil
      @grouping = :standard
      @catAxId = rand(8 ** 8)
      @valAxId = rand(8 ** 8)
      @serAxId = rand(8 ** 8)
      @catAxis = CatAxis.new(@catAxId, @valAxId)
      @valAxis = ValAxis.new(@valAxId, @catAxId)
      @serAxis = SerAxis.new(@serAxId, @valAxId)
      super(frame, options)
      @series_type = LineSeries
      @d_lbls = nil
    end

    # @see grouping
    def grouping=(v)
      @grouping = v
    end

    # @see gapDepth
    def gapDepth=(v)
      @gapDepth=(v)
    end

    # Serializes the object
    # @param [String] str
    # @return [String]
    def to_xml_string(str = '')
      super(str) do |str_inner|
        str_inner << '<c:lineChart>'
        str_inner << '<c:grouping val="' << grouping.to_s << '"/>'
        str_inner << '<c:varyColors val="0"/>'
        @series.each { |ser| ser.to_xml_string(str_inner) }
        @d_lbls.to_xml_string(str) if @d_lbls
        str_inner << '<c:gapDepth val="' << @gapDepth.to_s << '"/>' unless @gapDepth.nil?
        str_inner << '<c:axId val="' << @catAxId.to_s << '"/>'
        str_inner << '<c:axId val="' << @valAxId.to_s << '"/>'
        str_inner << '<c:axId val="' << @serAxId.to_s << '"/>'
        str_inner << '</c:lineChart>'
        @catAxis.to_xml_string str_inner
        @valAxis.to_xml_string str_inner
        @serAxis.to_xml_string str_inner
      end
    end
  end
end
