require 'spec_helper'

describe Station do

  describe '#twoway_connect_to' do
    before :each do
      @station_1 = Station.create
      @station_2 = Station.create
      @station_1.twoway_connect_to @station_2, 100
    end

    after :each do
      @station_1.destroy
      @station_2.destroy
    end

    it 'adds @station_1 to connections of station_2' do
      @station_2.connections.include? @station_1
    end

    it 'adds @station_2 to connections of station_1' do
      @station_1.connections.include? @station_2
    end
  end

end