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

    # def []=(i,j,v)
    #   @matrix[i][j] = v
    # end

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

   def insertar(i,h)
    @matrix[i] = h   
    puts @matrix.inspect 
   end

   def *(other)  #Para la multiplicacion de matrices
      ms = Hash.new(0)
      h = Hash.new(0)
      @mul = 0
      for k in @matrix.keys do
        # puts 
        # puts "ahora k: #{k}"
        for j in 0..other.hash.keys.count do
          # puts 
          # puts "ahora j: #{j}"
          for i in @matrix[k].keys do
            # puts 
            # puts "ahora i: #{i}"
              if other.hash[i][j] != 0 then
                @mul += @matrix[k][i] * other.hash[i][j]
                # puts "@mul es: #{@mul}"
              end
          end
          # puts "agrego en h[#{j}] #{@mul}"
          h[j] = @mul unless @mul == 0
          # puts h.inspect
          # puts "pongo a cero @mul"
          @mul = 0
        end
        # puts "agrego a ms[#{k}]: #{h}"
        ms[k] = h.clone unless h.empty?
        # puts ms.inspect
        # puts "vacio h"
        h.clear
        # puts "ahora mismo ms es: #{}"
        # puts ms.inspect
      end
      # puts ms.inspect
      ms2 = Matriz_dispersa.new(ms)
      # puts ms2[0].inspect
   end
end
