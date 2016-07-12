module WithSlavery
  attr_accessor :slavery_target

  # Supports queries like User.on_slave.to_a
  def exec_queries
    if slavery_target == :slave
      Slavery.on_slave { super }
    else
      super
    end
  end

  # Supports queries like User.on_slave.count
  def calculate(operation, column_name)
    if slavery_target == :slave
      Slavery.on_slave { super(operation, column_name) }
    else
      super(operation, column_name)
    end
  end
end

class ActiveRecord::Relation
  prepend WithSlavery
end
