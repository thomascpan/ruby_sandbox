require "./caesar_cipher"

describe "caesar_cipher" do
	
	it "translates a lower case word" do
		s = caesar_cipher("hello", 1)
		expect(s).to eq "ifmmp"
	end

	it "translates an upper case word" do
		s = caesar_cipher("HELLO", 1)
		expect(s).to eq "IFMMP"
	end

	it "translates a mix case word" do
		s = caesar_cipher("Hello", 1)
		expect(s).to eq "Ifmmp"
	end

	it "translates multiple words" do
		s = caesar_cipher("Hello Bob", 1)
		expect(s).to eq "Ifmmp Cpc"
	end

	it "translates multiple words with punctuations" do
		s = caesar_cipher("Hello, my name is Thomas!", 1)
		expect(s).to eq "Ifmmp, nz obnf jt Uipnbt!"
	end

	it "translates multiple words past end of alphabet" do
		s = caesar_cipher("Hello, my name is Thomas!", 5)
		expect(s).to eq "Mjqqt, rd sfrj nx Ymtrfx!"
	end

	it "doesn't translate special characters" do
		s = caesar_cipher("!@#$%^&*", 1)
		expect(s).to eq "!@#$%^&*"
	end
end
