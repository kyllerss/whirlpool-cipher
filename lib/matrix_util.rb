
class MatrixUtil

  def self.multiply(matrix1, matrix2, irreducible_polynomial=0x11D)

    unless matrix1[0].length == matrix2.length
      raise "First matrix length[].length must match second matrix[].length"
    end

    product = Array.new(matrix1.length) {Array.new(matrix2[0].length)}

    matrix1.each_index do |row|

      matrix2[0].each_index do |column|

        row_array = matrix1[row]
        column_array = extract_column(matrix2, column)
        product[row][column] = calculate_summation(row_array, column_array, irreducible_polynomial)
      end
    end

    return product
  end

  def self.calculate_summation(row_array, column_array, irreducible_polynomial)

    raise "Both arrays must be of same dimension." unless row_array.length == column_array.length

    product_summation = 0
    row_array.each_index do |i|

      # summation is done in GF(2^8) with irreducible polynomial
      product_summation = product_summation ^ multiply_in_gf2_8(row_array[i], column_array[i], irreducible_polynomial)
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

  def self.create_matrix(block)

    matrix = Array.new(8) {Array.new(8)}

    0.upto(63) do |i|

      row, column = i.divmod(8)

      matrix[row][column] = block[i]
    end

    return matrix
  end

  def self.chunk_to_matrices(initial_array)

    matrix_size = 512 / 8 # 512 bits (block size) / 8 (utf-8 char size)
    matrices = Array.new

    while initial_array.length > matrix_size
      matrices << MatrixUtil.create_matrix(initial_array.slice!(0, matrix_size))
    end

    last_index = initial_array.length
    elements_to_pad = matrix_size - initial_array.length
    initial_array.fill(" ".unpack("U")[0], last_index, elements_to_pad) # pad with " " (space)

    matrices << MatrixUtil.create_matrix(initial_array)

    return matrices
  end

  private

  # Perform multiplication in GF(2^8) with the irreducible polynomial:
  # This is accomplished by finding x * (... * (x * value2)...) % irreducible_polynomial
  # ... and then adding the products of those entries that correspond to the value1 where each
  # binary slot is 1.
  def self.multiply_in_gf2_8(value1, value2, irreducible_polynomial)

    # keeps track all the corresponding products
    products = Array.new

    # calculate x * (x * ... (x * value2)..)
    products << value2
    0.upto(7) do

      most_significant_bit = value2[7]
      if (most_significant_bit == 1)
        value2 <<= 1
        value2 ^= irreducible_polynomial
      else
        value2 <<= 1
      end

      value2 &= 0x0FF # zero-out any overflows (8-bits)

      products << value2
    end

    # add products for those matching the binary positions that make value1
    products_to_add = Array.new
    7.downto(0) {|i| products_to_add << products[i] if value1[i] == 1}

    # add (XOR) products to add
    result = products_to_add.inject {|summation, product| summation ^ product}

    return result != nil ? result : 0
  end
end
