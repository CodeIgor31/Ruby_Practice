# frozen_string_literal: true

require_relative 'main'

# Все данные для тестов взяты из GitHub gist
RSpec.describe Chain do
  # Тесты для функции valid?
  describe 'valid?' do
    it 'should return true' do
      per = Chain.new(%w[1976M6D4 1976M6D5 1976M6D6], '04.06.1976')
      expect(per.valid?).to eq(true)

      per = Chain.new(%w[2023 2024 2025], '16.07.2023')
      expect(per.valid?).to eq(true)

      per = Chain.new(%w[2023M1 2023M2 2023M3], '31.01.2023')
      expect(per.valid?).to eq(true)

      per = Chain.new(%w[2023M1 2023M2 2023M3D30], '30.01.2023')
      expect(per.valid?).to eq(true)

      per = Chain.new(%w[2020M1 2020 2021 2022 2023 2024M2 2024M3D30], '30.01.2020')
      expect(per.valid?).to eq(true)

      per = Chain.new(%w[2023M1 2023M2 2023M3D30], '30.01.2023')
      expect(per.valid?).to eq(true)

      per = Chain.new(['2023M2'], '01.02.2023')
      expect(per.valid?).to eq(true)

      per = Chain.new(%w[2023M12D31 2024M1 2024], '31.12.2023')
      expect(per.valid?).to eq(true)
    end

    it 'should return false' do
      per = Chain.new(%w[2023 2025 2026], '24.04.2023')
      expect(per.valid?).to eq(false)

      per = Chain.new(%w[2023M1 2023M3 2023M4], '10.01.2023')
      expect(per.valid?).to eq(false)

      per = Chain.new(%w[2023M5D2 2023M5D3 2023M5D5], '02.05.2023')
      expect(per.valid?).to eq(false)

      per = Chain.new(%w[2023M1 2023M2 2023M3D30], '31.01.2023')
      expect(per.valid?).to eq(false)

      per = Chain.new(%w[2020M1 2020 2021 2022 2023 2024M2 2024M3D29], '30.01.2020')
      expect(per.valid?).to eq(false)

      per = Chain.new(%w[2023M1 2023M2 2023M3D28], '27.01.2023')
      expect(per.valid?).to eq(false)

      per = Chain.new(%w[2023M1 2023M2 2023M3D30], '31.01.2023')
      expect(per.valid?).to eq(false)

      per = Chain.new(%w[2023M1D30 2023M1 2023M2 2023M3D30], '30.01.2023')
      expect(per.valid?).to eq(false)

      per = Chain.new(%w[2023M1D30 2023M1 2023M2 2023M3D30], '30.01.2023')
      expect(per.valid?).to eq(false)
    end
  end

  # Тесты для функции add
  describe 'add' do
    it 'should works for annually' do
      per = Chain.new(%w[2023M12D31 2024M1 2024], '31.12.2023')
      date_type = 'annually'
      expect(per.add(date_type)).to eq(%w[2023M12D31 2024M1 2024 2025])
    end

    it 'should works for monthly' do
      per = Chain.new(%w[2023M1D30 2023M1 2023M2], '30.01.2023')
      date_type = 'monthly'
      expect(per.add(date_type)).to eq(%w[2023M1D30 2023M1 2023M2 2023M3])
    end

    it 'should works for daily' do
      per = Chain.new(%w[2023M1D30 2023M1 2023M2 2023M3D30], '30.01.2023')
      date_type = 'daily'
      expect(per.add(date_type)).to eq(%w[2023M1D30 2023M1 2023M2 2023M3D30 2023M3D31])
    end

    it 'should works for daily: second variant' do
      per = Chain.new(%w[2023M1D30 2023M1 2023M2 2023M3D31], '30.01.2023')
      date_type = 'daily'
      expect(per.add(date_type)).to eq(%w[2023M1D30 2023M1 2023M2 2023M3D31 2023M4D1])
    end
  end
end
