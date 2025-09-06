def suspicious_rotate_matrix_counter_clockwise(matrix)
  return matrix if matrix.blank?
  length = matrix.size
  height = matrix.first.size

  max_size_index = [length, height].max - 1

  (0..max_size_index).each do |xy|
    (xy..max_size_index).each do |y|
      if not matrix[y] and matrix[xy][y]
        matrix.push [matrix[xy][y]]
        matrix[xy].delete y
        puts "swapped matrix[#{y}][#{xy}] with matrix[#{xy}][#{y}]" if not matrix[y] and matrix[xy][y]
        puts matrix
        # binding.pry
        next
      end

      matrix.push [] unless matrix[y]
      if matrix[xy][y]
        swap = matrix[y][xy]
        matrix[y][xy] = matrix[xy][y]
        matrix[xy][y] = swap
      end
      puts "swapped matrix[#{y}][#{xy}] with matrix[#{xy}][#{y}]" if matrix[xy][y]
      puts matrix
      # binding.pry
    end
  end

  # (0...length).each do |x|
  #   (0...height).each do |y|
  #     # result[height - 1 - y][x] = matrix[x][y] ## swapping
  #
  #   end
  # end

  return matrix
end

# def suspicious_rotate_matrix_counter_clockwise(matrix)
#   return matrix if matrix.blank?
#   length = matrix.size # 1
#   height = matrix.first.size # 1
#   result = Array.new(height) { Array.new(length, 0) } # size of matrix O(x * y)
#
#   # space complex = O(x * y)
#
#   (0...length).each do |x|
#     (0...height).each do |y|
#       result[height - 1 - y][x] = matrix[x][y]
#     end
#   end
#
#   return result
# end

# spec/suspicious_rotate_matrix_counter_clockwise_spec.rb

require 'rails_helper'

shared_examples :testing_suspicious_rotate_matrix_counter_clockwise do
  it "rotates the matrix 90 degrees counter-clockwise" do
    rotated_matrix = suspicious_rotate_matrix_counter_clockwise(original_matrix)
    expect(rotated_matrix).to eq expected_matrix
  end
end

describe "suspicious_rotate_matrix_counter_clockwise" do
  describe "when testing various matrix sizes" do

    context "when matrix is 4x4" do
      let(:original_matrix) {
        [
          [1,  2,  3,  4],
          [5,  6,  7,  8],
        ]
      }

      # [
      #   [1,  5],
      #   [2,  6,  7,  8],
      #   [3],
      #   [4]
      # ]

      # [
      #   [1,  5,  9],
      #   [2,  6,  10],
      #   [3,  7, 11, 12],
      #   [4,  8]
      # ]
      #
      # [
      #   [1,  5,  9],
      #   [2,  6,  10],
      #   [3,  7, 11],
      #   [4,  8, 12]
      # ]

      # [
      #   [1,  5,  9],
      #   [2,  6,  7,  8],
      #   [3,  10, 11, 12],
      #   [4]
      # ]


      # [
      #   [4,  5,  9,  13],
      #   [3,  6,  7,  8],
      #   [2,  10, 11, 12],
      #   [1, 14, 15, 16]
      # ]
      #
      # [
      #    [4,  8,  5,  13,
      #    [3,  7,  10,  9],
      #    [2,  6, 11, 12],
      #    [1, 14, 15, 16]
      #   ]

      let(:expected_matrix) {
        [
          [4, 8, 12, 16],
          [3, 7, 11, 15],
          [2, 6, 10, 14],
          [1, 5, 9, 13]
        ]
      }
      include_examples :testing_suspicious_rotate_matrix_counter_clockwise
    end

    context "when matrix is nil" do
      let(:original_matrix) { nil }
      let(:expected_matrix) { nil }
      include_examples :testing_suspicious_rotate_matrix_counter_clockwise
    end

    context "when matrix is empty" do
      let(:original_matrix) { [] }
      let(:expected_matrix) { [] }
      include_examples :testing_suspicious_rotate_matrix_counter_clockwise
    end

    context "when matrix is 1x1" do
      let(:original_matrix) { [[1]] }
      let(:expected_matrix) { [[1]] }
      include_examples :testing_suspicious_rotate_matrix_counter_clockwise
    end

    context "when matrix is 1x2" do
      let(:original_matrix) {
        [
          [1, 2]
        ]
      }
      let(:expected_matrix) {
        [
          [2],
          [1]
        ]
      }
      include_examples :testing_suspicious_rotate_matrix_counter_clockwise
    end

    context "when matrix is 2x2" do
      let(:original_matrix) {
        [
          [1, 2],
          [3, 4]
        ]
      }
      let(:expected_matrix) {
        [
          [2, 4],
          [1, 3]
        ]
      }
      include_examples :testing_suspicious_rotate_matrix_counter_clockwise
    end

    context "when matrix is 2x1" do
      let(:original_matrix) {
        [
          [1],
          [2]
        ]
      }
      let(:expected_matrix) {
        [
          [1, 2]
        ]
      }
      include_examples :testing_suspicious_rotate_matrix_counter_clockwise
    end

    context "when matrix is 1x3" do
      let(:original_matrix) {
        [
          [1, 2, 3]
        ]
      }
      let(:expected_matrix) {
        [
          [3],
          [2],
          [1]
        ]
      }
      include_examples :testing_suspicious_rotate_matrix_counter_clockwise
    end

    context "when matrix is 3x3" do
      let(:original_matrix) {
        [
          [1, 2, 3],
          [4, 5, 6],
          [7, 8, 9]
        ]
      }
      let(:expected_matrix) {
        [
          [3, 6, 9],
          [2, 5, 8],
          [1, 4, 7]
        ]
      }
      include_examples :testing_suspicious_rotate_matrix_counter_clockwise
    end

    context "when matrix is 3x1" do
      let(:original_matrix) {
        [
          [1],
          [2],
          [3]
        ]
      }
      let(:expected_matrix) {
        [
          [1, 2, 3]
        ]
      }
      include_examples :testing_suspicious_rotate_matrix_counter_clockwise
    end

    context "when matrix is 1x4" do
      let(:original_matrix) {
        [
          [1, 2, 3, 4]
        ]
      }
      let(:expected_matrix) {
        [
          [4],
          [3],
          [2],
          [1]
        ]
      }
      include_examples :testing_suspicious_rotate_matrix_counter_clockwise
    end

    context "when matrix is 2x4" do
      let(:original_matrix) {
        [
          [1, 2, 3, 4],
          [5, 6, 7, 8]
        ]
      }
      let(:expected_matrix) {
        [
          [4, 8],
          [3, 7],
          [2, 6],
          [1, 5]
        ]
      }
      include_examples :testing_suspicious_rotate_matrix_counter_clockwise
    end

    context "when matrix is 3x4" do
      let(:original_matrix) {
        [
          [1, 2, 3, 4],
          [5, 6, 7, 8],
          [9, 10, 11, 12]
        ]
      }
      let(:expected_matrix) {
        [
          [4, 8, 12],
          [3, 7, 11],
          [2, 6, 10],
          [1, 5, 9]
        ]
      }
      include_examples :testing_suspicious_rotate_matrix_counter_clockwise
    end



    context "when matrix is 4x4" do
      let(:original_matrix) {
        [
          [1,  2,  3,  4],
          [5,  6,  7,  8],
          [9,  10, nil, 12],
          [13, 14, 15, nil]
        ]
      }
      let(:expected_matrix) {
        [
          [4, 8, 12, nil],
          [3, 7, nil, 15],
          [2, 6, 10, 14],
          [1, 5, 9, 13]
        ]
      }
      include_examples :testing_suspicious_rotate_matrix_counter_clockwise
    end
  end
end