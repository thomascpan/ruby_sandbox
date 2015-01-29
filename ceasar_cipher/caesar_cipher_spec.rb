require "caesar_cipher"

describe "caesar_cipher" do 
	
	it "caesar_cipher lower case word" do
		s = caesar_cipher("hello", 1)
		s.should == "ifmmp"
	end

	it "caesar_cipher upper case word" do
		s = caesar_cipher("HELLO", 1)
		s.should == "IFMMP"
	end

	it "caesar_cipher mix case word" do
		s = caesar_cipher("Hello", 1)
		s.should == "Ifmmp"
	end

	it "caesar_cipher multiple words" do
		s = caesar_cipher("Hello Bob", 1)
		s.should == "Ifmmp Cmc"
	end

	it "caesar_cipher multiple words with punctuations" do
		s = caesar_cipher("Hello, my name is Thomas!", 1)
		s.should == "Ifmmp, nz obnf jt Uipnbt!"
	end

	it "caesar_cipher multiple words past end of alphabet" do
		s = caesar_cipher("Hello, my name is Thomas!", 5)
		s.should == "Mjqqt, rd sfrj nx Ymtrfx!"
	end
end
