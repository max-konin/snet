require 'spec_helper'

describe PrimaAlgorithm do

  describe '.do!' do
    describe 'simple case' do
      before :each do
        @job = FactoryGirl.create :job
        @stations = []
        4.times { |i| @stations << FactoryGirl.create(:station, job_id: @job.id, name: "s-#{i}")}
        3.times { |i| @stations[i].twoway_connect_to @stations[i+1], (i + 1) * 10 }
        @stations[0].twoway_connect_to @stations[3], 11
      end

      after :each do
        @job.destroy!
      end

      it 'build mst' do
        PrimaAlgorithm.do! @stations
        expect(@stations[0].connections_to_other([@stations[1], @stations[3]]).count).to eq(2)
        expect(@stations[1].connections_to_other(@stations[2]).count).to eq(1)
        expect(@stations[2].connections_to_other(@stations[3]).count).to eq(0)
      end
    end
  end

end