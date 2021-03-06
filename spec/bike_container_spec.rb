require 'bike_container'

class ContainerHolder; include BikeContainer; end

describe BikeContainer do

	let(:bike) { Bike.new }
	let(:holder) { ContainerHolder.new}

	def fill_holder(holder)
		20.times{ holder.dock(bike) }
	end

	it 'should accept a bike' do
		expect(holder.bike_count).to eq(0)
		holder.dock(bike)
		expect(holder.bike_count).to eq(1)
	end

	it 'should release a bike' do
		holder.dock(bike)
		holder.release(bike)
		expect(holder.bike_count).to eq(0)
	end

	it 'should know when it\'s full' do
	 	expect(holder).not_to be_full
	 	fill_holder(holder)
	 	expect(holder).to be_full
	end

	it 'should not accept a bike if it is full' do
		fill_holder holder
		expect{ holder.dock(bike) }.to raise_error(RuntimeError, 'Holder is full')
	end

	it 'should provide the list of avaliable bikes' do
		working_bike, broken_bike = Bike.new, Bike.new
		broken_bike.break!
		holder.dock(working_bike)
		holder.dock(broken_bike)
		expect(holder.avaliable_bikes).to eq([working_bike])
	end


end