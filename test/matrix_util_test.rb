# To change this template, choose Tools | Templates
# and open the template in the editor.

$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require 'matrix_util'

class MatrixUtilTest < Test::Unit::TestCase
  def test_extract_column

    test_matrix = [['0', '1', '2', '3'],
                  ['a', 'b', 'c', 'd'],
                  ['A', 'B', 'C', 'D']]

    column_array = MatrixUtil.extract_column(test_matrix, 1)

    expected_array = ['1', 'b', 'B']

    assert_equal(column_array, expected_array)

  end

  def test_summation

    array1 = [1, 2, 3]
    array2 = [1, 2, 3]

    summation = MatrixUtil.calculate_summation(array1, array2)

    expected_summation = 14

    assert_equal expected_summation, summation
  end

  def test_multiply

    matrix1 = [[1, 2, 3]]
    matrix2 = [[1, 1],
               [2, 2],
               [3, 3]]

    expected_matrix = [[14, 14]]

    result_matrix = MatrixUtil.multiply(matrix1, matrix2)

    assert_equal expected_matrix, result_matrix
  end

  def test_chunk_to_matrices

    initial_array = Array.new(129) {|i| i}

    matrices = MatrixUtil.chunk_to_matrices(initial_array)

    assert_not_nil matrices
    assert matrices.length == 3

    first_matrix = matrices[0]
    assert first_matrix[0][0] = 0
    assert first_matrix[7][7] = 63

    second_matrix = matrices[1]
    assert second_matrix[0][0] = 64
    assert second_matrix[7][7] = 127

    third_matrix = matrices[2]
    assert third_matrix[0][0] = 128
    assert third_matrix[7][7] = 32
  end
end
