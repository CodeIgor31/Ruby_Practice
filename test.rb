# frozen_string_literal: true

require_relative 'main'

RSpec.describe Case do
  describe 'function' do
    it 'should works' do
      per = %w[1976M6D4 1976M6D5 1976M6D6]
      start = '04.06.1976'
      expect(described_class.check(start, per)).to eq(true)
    end

    it 'should works' do
      per = %w[2023 2024 2025]
      start = '16.07.2023'
      expect(described_class.check(start, per)).to eq(true)
    end

    it 'should works' do
      per = %w[2023 2025 2026]
      start = '24.04.2023'
      expect(described_class.check(start, per)).to eq(false)
    end

    it 'should works' do
      per = %w[2023M1 2023M2 2023M3]
      start = '31.01.2023'
      expect(described_class.check(start, per)).to eq(true)
    end

    it 'should works' do
      per = %w[2023M1 2023M3 2023M4]
      start = '10.01.2023'
      expect(described_class.check(start, per)).to eq(false)
    end

    it 'should works' do
      per = %w[2023M5D2 2023M5D3 2023M5D5]
      start = '02.05.2023'
      expect(described_class.check(start, per)).to eq(false)
    end

    it 'should works' do
      per = %w[2023M1 2023M2 2023M3D30]
      start = '30.01.2023'
      expect(described_class.check(start, per)).to eq(true)
    end

    it 'should works' do
      per = %w[2023M1 2023M2 2023M3D30]
      start = '31.01.2023'
      expect(described_class.check(start, per)).to eq(false)
    end

    it 'should works' do
      per = %w[2020M1 2020 2021 2022 2023 2024M2 2024M3D30]
      start = '30.01.2020'
      expect(described_class.check(start, per)).to eq(true)
    end

    it 'should works' do
      per = %w[2020M1 2020 2021 2022 2023 2024M2 2024M3D29]
      start = '30.01.2020'
      expect(described_class.check(start, per)).to eq(false)
    end

    it 'should works' do
      per = ["2023M1", "2023M2", "2023M3D28"]
      start = '27.01.2023'
      expect(described_class.check(start, per)).to eq(false)
    end

    it 'should works' do
      per = ["2023M1", "2023M2", "2023M3D30"] 
      start = '30.01.2023'
      expect(described_class.check(start, per)).to eq(true)
    end

    it 'should works' do
      per = ["2023M1", "2023M2", "2023M3D30"]
      start = '31.01.2023'
      expect(described_class.check(start, per)).to eq(false)
    end

    it 'should works' do
      per = ["2023M1D30", "2023M1", "2023M2", "2023M3D30"]
      start = '30.01.2023'
      expect(described_class.check(start, per)).to eq(false)
    end

    it 'should works' do
      per = ["2023M2"] 
      start = '01.02.2023'
      expect(described_class.check(start, per)).to eq(true)
    end

    it 'should works' do
      per = ["2023M1D30", "2023M1", "2023M2", "2023M3D30"]
      start = '30.01.2023'
      expect(described_class.check(start, per)).to eq(false)
    end

  end
end
