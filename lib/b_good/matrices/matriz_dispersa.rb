class Vector_disperso
	attr_reader :vector

	def initialize(h = {})
    	@vector = Hash.new(0)
    	@vector = @vector.merge!(h)
  	end

  	def to_s
    @vector.to_s
 	end

	def [](i)
    	@vector[i] 
  	end
end

class Matriz_dispersa < Matriz
	
	attr_reader :matrix

	def initialize(h = {})
   	@matrix = Hash.new({})
    	for k in h.keys do 
      	@matrix[k] = 	if h[k].is_a? Vector_disperso
         						h[k]
            				else 
                     		@matrix[k] = Vector_disperso.new(h[k])
                   		end
    	end
  	end

  	def [](i)
    	@matrix[i]
  	end

  	def col(j)
    	c = {}
    	for r in @matrix.keys do
      	c[r] = @matrix[r].vector[j] if @matrix[r].vector.keys.include? j
    	end
    	Vector_disperso.new c
  	end

	def +(other)  #Para la suma de matrices
   end

   def -(other)  #Para la resta de matrices
   end

   def *(other)  #Para la multiplicacion de matrices
   end

   
end
