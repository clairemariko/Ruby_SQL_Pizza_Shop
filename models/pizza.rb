require( 'pg' )

class Pizza

  attr_reader( :first_name, :last_name, :topping, :quantity, :id)

  def initialize( options )
    @id = nil || options['id']
    @first_name = options['first_name']
    @last_name = options['last_name']
    @topping = options['topping']
    @quantity = options['quantity'].to_i
  end

  def pretty_name()
    return @first_name.concat(" #{@last_name}")
  end

  def total() 
    return @quantity * 10
  end

  def save()
    sql = "INSERT INTO pizzas ( 
      first_name, 
      last_name, 
      topping, 
      quantity ) VALUES (
      '#{ @first_name }',
      '#{ @last_name }',
      '#{ @topping }',
      '#{ @quantity }'
      )"
    Pizza.run_sql(sql)
  end

  def self.all()
    pizzas = Pizza.run_sql("SELECT * FROM pizzas")
    result = pizzas.map { |pizza| Pizza.new( pizza ) }
   
    return result
  end

 def self.find( id ) #MAKE SURE THIS IS NOT A SYMBOL
    pizza = Pizza.run_sql( "SELECT * from pizzas WHERE id=#{id}")
    result = Pizza.new( pizza.first )
    return result
 end

  
  def self.update(options)
    sql = "UPDATE pizzas SET 
      first_name='#{options['first_name']}',
      last_name='#{options['last_name']}',
      topping='#{options['topping']}',
      quantity='#{options['quantity']}'
      WHERE id='#{options['id']}'"
    Pizza.run_sql(sql)
  end

  def self.destroy(id)
    Pizza.run_sql("DELETE FROM pizzas WHERE id=#{id}")
  end

  private
  def self.run_sql(sql)
    begin 
      db = PG.connect( { dbname: 'pizza_shop', host: 'localhost' } )
      result = db.exec(sql)
      return result
    ensure
      db.close
    end
  end



end