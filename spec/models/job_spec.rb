require 'spec_helper'

describe Job do
  describe '#dotting_stations!' do
    describe 'simple' do
      before do
        @job = FactoryGirl.create :job
        FactoryGirl.create :region, job_id: @job.id, points: [FactoryGirl.create(:point, latitude: 0, longitude: 0)]
        FactoryGirl.create :region, job_id: @job.id, points: [FactoryGirl.create(:point, latitude: 2, longitude: 2)]
      end

      it 'create one station' do
        expect{@job.dotting_stations! 1000}.to change{@job.stations.count}.to(1)
      end

      it 'return station with cords (1,1)' do
        @job.dotting_stations! 1000
        stations = @job.stations
        expect(stations.first.latitude).to  eq(1)
        expect(stations.first.longitude).to eq(1)
      end

    end
  end


  describe '#regions' do
    before do
      @job = FactoryGirl.create :job
      @regions = [FactoryGirl.create(:region, job_id: @job.id),
                  FactoryGirl.create(:region, job_id: @job.id)]
    end
    it 'return all region for job from Neo4j' do
      expect(@job.regions.each.to_a && @regions).not_to be_empty
    end
  end

  describe '#create_region!' do
    it 'cannot create region if job was not saved' do
      job = FactoryGirl.build :job
      expect{job.create_region!}.to raise_error(ActiveRecord::RecordNotSaved)
    end

    it "create region with job_id eq owner's id" do
      job = FactoryGirl.create :job
      expect(job.create_region!.job_id).to eq(job.id)
    end
  end

  describe '#build_region' do
    it 'cannot create region if job was not saved' do
      job = FactoryGirl.build :job
      expect{job.build_region}.to raise_error(ActiveRecord::RecordNotSaved)
    end

    it "return region with job_id eq owner's id" do
      job = FactoryGirl.create :job
      expect(job.build_region.job_id).to eq(job.id)
    end
  end


  describe '#create_station!' do
    it 'cannot create region if job was not saved' do
      job = FactoryGirl.build :job
      expect{job.create_station!}.to raise_error(ActiveRecord::RecordNotSaved)
    end

    it "create region with job_id eq owner's id" do
      job = FactoryGirl.create :job
      expect(job.create_station!.job_id).to eq(job.id)
    end
  end

  describe '#build_station' do
    it 'cannot create region if job was not saved' do
      job = FactoryGirl.build :job
      expect{job.build_station}.to raise_error(ActiveRecord::RecordNotSaved)
    end

    it "return region with job_id eq owner's id" do
      job = FactoryGirl.create :job
      expect(job.build_station.job_id).to eq(job.id)
    end
  end
end
