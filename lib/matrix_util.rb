
class MatrixUtil

  def self.multiply(matrix1, matrix2)

    unless matrix1[0].length == matrix2.length
      raise "First matrix length[].length must match second matrix[].length"
    end

    product = Array.new(matrix1.length) {Array.new(matrix2[0].length)}

    matrix1.each_index do |row|

      matrix2[0].each_index do |column|

        row_array = matrix1[row]
        column_array = extract_column(matrix2, column)
        product[row][column] = calculate_summation(row_array, column_array)
      end
    end

    return product
  end

  def self.calculate_summation(row_array, column_array)

    raise "Both arrays must be of same dimension." unless row_array.length == column_array.length
    product_summation = 0
    row_array.each_index do |i|

      product_summation = product_summation + row_array[i] * column_array[i]
    end

    return product_summation
  end

  def self.extract_column(matrix, column)

    column_array = Array.new()
    matrix.each_index do |row|
        column_array << matrix[row][column]
    end

    return column_array
  end
end
