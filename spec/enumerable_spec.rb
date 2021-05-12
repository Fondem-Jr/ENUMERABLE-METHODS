# spec/enumerable_spec.rb

require 'spec_helper'
require_relative '../script'

my_array = (1..10).to_a
my_hash = {"a" => 100, "b" => 200}




RSpec.describe Enumerable do
    context 'Testing #my_each' do
        describe 'for arrays' do
            it 'returns an emunerable when no block given' do
                my_result = my_array.my_each.class
                std_result = my_array.each.class
                expect(my_result).to eql(std_result)
            end
            it 'when the given an array' do
                std_result = []
                my_array.each do |j|
                std_result.push(j + j)
                end
                my_result = []
                my_array.my_each do |j|
                my_result.push(j + j)
                end
                expect(my_result).to eql(std_result)
            end
        end
        describe 'for hashes' do
            it 'when given a hash' do
              std_result = []
              my_hash.each do |i, h|
                std_result.push(h)
              end
              my_result = []
              my_hash.my_each do |i, h|
                my_result.push(h)
              end
              expect(my_result).to eql(std_result)
            end
        end
    end

    context 'Testing #my_each_with_index' do
        describe 'for arrays' do
            it 'returns an emunerable when no block given' do
                my_result = my_array.my_each_with_index.class
                std_result = my_array.each_with_index.class
                expect(my_result).to eql(std_result)
            end
            it 'when the given an array' do
                std_result = []
                my_array.each_with_index do |j, i|
                std_result.push(j)
                end
                my_result = []
                my_array.my_each do |j, i|
                my_result.push(j)
                end
                expect(my_result).to eql(std_result)
            end
        end

        describe 'for hashes' do
            it 'when the given a hash' do
              std_result = []
              my_hash.each_with_index do |i, h|
                std_result.push(h)
              end
              my_result = []
              my_hash.my_each_with_index do |i, h|
                my_result.push(h)
              end
              expect(my_result).to eql(std_result)
            end
        end
    end

    context 'Testing #my_select' do
        describe 'for no block given' do
           it 'returns an emunerable when no block given' do
            my_result = my_array.my_select.class
            std_result = my_array.select.class
            expect(my_result).to eql(std_result)
           end
        end

        describe 'for arrays' do
           it 'returns selected elements of the array' do
           my_result = my_array.my_select(&:odd?)
           std_result = my_array.select(&:odd?)
           expect(my_result).to eql(std_result)  
           end
        end
        # describe 'for hash' do
        #     it 'returns selected elementd of the hash' do
        #         my_result = my_hash.my_select do |_, h|
        #             h.is_a? String
        #         end
        #         std_result = my_hash.select do |_, h|
        #             h.is_a? String
        #         end
        #         expect(my_result).to eql(std_result)
        #     end
        # end
    end
end