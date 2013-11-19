class Vector_disperso
	attr_reader :vector

	def initialize(h = {})
    	@vector = Hash.new(0)
    	@vector = @vector.merge!(h)
  	end

  	def to_s
    @vector.to_s
 	end

 	def keys
 		@vector.keys
 	end

  def hash
    @vector
  end

  def +(other)
    @vector.merge!(other.hash){|key, oldval, newval| newval + oldval}
  end

  def -(other)
    @vector.merge!(other.hash){|key, oldval, newval| newval - oldval}
  end

 	def []= (i,v)
 		@vector[i] = v
 	end

	def [](i)
    	@vector[i] 
  	end
end

class Matriz_dispersa < Matriz
	
	attr_reader :matrix

	def initialize(h = {})
   	@matrix = Hash.new(0)
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

    def hash
      @matrix
    end

  	def keys
  		@matrix.keys
  	end

  	def col(j)
    	c = {}
    	for r in @matrix.keys do
      	c[r] = @matrix[r].vector[j] if @matrix[r].vector.keys.include? j
    	end
    	Vector_disperso.new c
  	end

	def +(other)  #Para la suma de matrices
		ms = @matrix.clone
		ms.merge!(other.hash){ |key, oldval, newval| newval + oldval}
   end

   def -(other)  #Para la resta de matrices
    ms = @matrix.clone
    ms.merge!(other.hash){ |key, oldval, newval| newval - oldval}
   end

   # def *(other)  #Para la multiplicacion de matrices
   # end
end
