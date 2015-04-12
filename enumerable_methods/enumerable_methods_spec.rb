require "./enumerable_methods"

describe Enumerable do

		let(:a) {[1, 2, 3]}
		let(:all_false) {[false, nil, false, nil]}
		let(:some_false) {[1, false, 2, nil]}

	describe "#my_each" do
		context "when no block is given" do
			it "returns an enumerable object" do
				expect(a.my_each).to be_instance_of Enumerator
			end
		end

		context "when block is given" do
			it "returns an array object" do
				expect(a.my_each { |x| x }).to be_instance_of Array
			end

			it "it returns itself" do
				expect(a.my_each { |x| x }).to eq a
			end

			it "it executes block" do
				a = []
				b = [1, 2, 3]
				b.my_each { |x| a << x }
				expect(a).to eq b
			end
		end
	end

	describe "#my_each_with_index" do
		context "when no block is given" do
			it "returns an enumerable object" do
				expect(a.my_each_with_index).to be_instance_of Enumerator
			end
		end

		context "when block is given" do
			it "returns an array object" do
				expect(a.my_each_with_index { |x, i| x + i }).to be_instance_of Array
			end

			it "returns original array" do
				expect(a.my_each_with_index {|x, i| x + i }).to eq a
			end

			it "executes block" do
				a = []
				b = ["a", "b", "c"]
				b.my_each_with_index { |x,i| a << "#{x}:#{i}"}
				expect(a).to eq ["a:0", "b:1", "c:2"]
			end
		end
	end

	describe "#my_select" do
		context "when no block is given" do
			it "returns an enumerable object" do
				expect(a.my_select).to be_instance_of Enumerator
			end
		end

		context "when block is given" do
			it "returns an Array object" do
				expect(a.my_select { |x| x > 0 }).to be_instance_of Array
			end

			it "executes block" do
				expect(a.my_select {|x| x > 2}).to eq [3]
			end
		end
	end

	describe "#my_all?" do
		context "when no block is given" do
			it "returns true if all elements in array are true" do
				expect(a.my_all?).to eq true
			end

			it "returns false if not all elements in array are true" do
				expect(some_false.my_all?).to eq false
			end
		end

		context "when block is given" do
			it "executes block and returns true if all elements are true after being passed into the block" do 
				expect(a.my_all? { |x| x > 0}).to eq true
			end

			it "executes block and returns false if not all elements are true after being passed into the block" do
				expect(a.my_all? { |x| x > 2 }).to eq false 
			end
		end
	end

	describe "#my_any?" do
		context "when no block is given" do
			it "returns true if any elements in array are true" do
				expect(a.my_any?).to eq true
				expect(some_false.my_any?).to eq true
				expect(all_false.my_any?).to eq false
			end
		end

		context "when block is given" do
			it "returns true if any element are true after being passed into block" do
				expect(a.my_any? { |x| x > 1}).to eq true
				expect(a.my_any? { |x| x < 0}).to eq false
				expect(some_false.my_any? { |x| x.nil? }).to eq true
				expect(all_false.my_any? { |x| x.nil? }).to eq true
			end
		end
	end

	describe "#my_none?" do
		context "when no block is given" do
			it "returns true if none of the elements in array are true" do
				expect(a.my_none?).to eq false
				expect(some_false.my_none?).to eq false
				expect(all_false.my_none?).to eq true
			end
		end

		context "when block is given" do
			it "returns true if none of the elements are true after being passed into block" do
				expect(a.my_none? { |x| x<0 }).to eq true
				expect(some_false.my_none? { |x| x.nil? }).to eq false
				expect(all_false.my_none? {|x| x.nil? }).to eq false
			end
		end
	end

	describe "#my_count" do
		context "when block is not given" do
			it "returns number of elements in array" do 
				expect(a.my_count).to eq 3
				expect(some_false.my_count).to eq 4
				expect(all_false.my_count).to eq 4
			end
		end

		context "when block is given" do
			it "returns number of elements that are true when passed into block" do
				expect(a.my_count { |x| x == 1}).to eq 1
				expect(some_false.my_count { |x| x == nil }).to eq 1
				expect(all_false.my_count { |x| x == nil }).to eq 2
				expect(all_false.my_count(nil)).to eq 2
			end
		end
	end

	describe "#my_map" do
		context "when block is not given" do
			it "returns an enumerable object" do
				expect(a.my_map).to be_instance_of Enumerator
			end
		end

		context "when block is not given, but proc is given" do
			it "returns result of array passed through proc" do
				add = Proc.new {|x| x+2 }
				expect(a.my_map(&add)).to be_instance_of Array
				expect(a.my_map(&add)).to eq [3, 4, 5]
			end
		end

		context "when block is given and proc is not given" do
			it "returns result of array passed through block" do
				expect(a.my_map {|x| x * 2}).to be_instance_of Array
				expect(a.my_map {|x| x * 2}).to eq [2, 4, 6]
			end
		end
	end

	describe "#my_inject" do
		context "when block is given" do
			it "returns result of block" do
				expect(a.my_inject {|s, x| s + x }).to eq 6
				expect(a.my_inject {|d, x| d - x }).to eq -4
			end
		end

		context "when block is not given" do
			it "returns result when parameter is given" do
				expect(a.my_inject(:+)).to eq 6
				expect(a.my_inject(10, :+)).to eq 16
				expect(a.my_inject(-5, :*)).to eq -30
			end
		end
	end
end