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
end
