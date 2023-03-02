# frozen_string_literal: true

require_relative 'main'

RSpec.describe Chain do
  describe 'function' do
    it 'should works' do
      per = Chain.new(%w[1976M6D4 1976M6D5 1976M6D6], '04.06.1976')
      expect(per.valid?).to eq(true)
    end

    it 'should works' do
      per = Chain.new(%w[2023 2024 2025], '16.07.2023')
      expect(per.valid?).to eq(true)
    end

    it 'should works' do
      per = Chain.new(%w[2023 2025 2026], '24.04.2023')
      expect(per.valid?).to eq(false)
    end

    it 'should works' do
      per = Chain.new(%w[2023M1 2023M2 2023M3], '31.01.2023')
      expect(per.valid?).to eq(true)
    end

    it 'should works' do
      per = Chain.new(%w[2023M1 2023M3 2023M4], '10.01.2023')
      expect(per.valid?).to eq(false)
    end

    it 'should works' do
      per = Chain.new(%w[2023M5D2 2023M5D3 2023M5D5], '02.05.2023')
      expect(per.valid?).to eq(false)
    end

    it 'should works' do
      per = Chain.new(%w[2023M1 2023M2 2023M3D30], '30.01.2023')
      expect(per.valid?).to eq(true)
    end

    it 'should works' do
      per = Chain.new(%w[2023M1 2023M2 2023M3D30], '31.01.2023')
      expect(per.valid?).to eq(false)
    end

    it 'should works' do
      per = Chain.new(%w[2020M1 2020 2021 2022 2023 2024M2 2024M3D30], '30.01.2020')
      expect(per.valid?).to eq(true)
    end

    it 'should works' do
      per = Chain.new(%w[2020M1 2020 2021 2022 2023 2024M2 2024M3D29], '30.01.2020')
      expect(per.valid?).to eq(false)
    end

    it 'should works' do
      per = Chain.new(%w[2023M1 2023M2 2023M3D28], '27.01.2023')
      expect(per.valid?).to eq(false)
    end

    it 'should works' do
      per = Chain.new(%w[2023M1 2023M2 2023M3D30], '30.01.2023')
      expect(per.valid?).to eq(true)
    end

    it 'should works' do
      per = Chain.new(%w[2023M1 2023M2 2023M3D30], '31.01.2023')
      expect(per.valid?).to eq(false)
    end

    it 'should works' do
      per = Chain.new(%w[2023M1D30 2023M1 2023M2 2023M3D30], '30.01.2023')
      expect(per.valid?).to eq(false)
    end

    it 'should works' do
      per = Chain.new(['2023M2'], '01.02.2023')
      expect(per.valid?).to eq(true)
    end

    it 'should works' do
      per = Chain.new(%w[2023M1D30 2023M1 2023M2 2023M3D30], '30.01.2023')
      expect(per.valid?).to eq(false)
    end
  end
end
