require 'rails_helper'

RSpec.describe Users::Create, type: :interaction do
  let(:email) { 'test@example.com' }
  let(:valid_params) do
    {
      name: 'John',
      surname: 'Doe',
      patronymic: 'Smith',
      email: email,
      gender: 'male',
      nationality: 'American',
      country: 'USA',
      age: 30,
      interests: ['Sports', 'Music'],
      skills: ['Ruby', 'Rails']
    }
  end

  let!(:interest1) { create(:interest, name: 'Sports') }
  let!(:interest2) { create(:interest, name: 'Music') }
  let!(:skill1) { create(:skill, name: 'Ruby') }
  let!(:skill2) { create(:skill, name: 'Rails') }

  describe '#execute' do
    it 'creates a user with valid attributes' do
      result = described_class.run(valid_params)
      expect(result).to be_valid
      expect(User.find_by(email: email)).to be_present
      expect(result.interests).to contain_exactly('Sports', 'Music')
      expect(result.skills).to contain_exactly('Ruby', 'Rails')
    end

    it 'fails when email is not unique' do
      create(:user, email: email)
      result = described_class.run(valid_params)
      expect(result).not_to be_valid
      expect(result.errors[:email]).to include('has already been taken')
    end

    it 'fails when age is invalid' do
      invalid_params = valid_params.merge(age: -5)
      result = described_class.run(invalid_params)
      expect(result).not_to be_valid
      expect(result.errors[:age]).to include('must be greater than 0')
    end

    it 'fails with invalid gender' do
      invalid_params = valid_params.merge(gender: 'unknown')
      result = described_class.run(invalid_params)
      expect(result).not_to be_valid
      expect(result.errors[:gender]).to include('is not included in the list')
    end
  end
end