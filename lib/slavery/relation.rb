class ActiveRecord::Relation
  attr_accessor :slavery_target

  # Supports queries like User.on_slave.to_a
  alias_method :original_exec_queries, :exec_queries
  def exec_queries
    if slavery_target == :slave
      Slavery.on_slave { original_exec_queries }
    else
      original_exec_queries
    end
  end

  # Supports queries like User.on_slave.count
  alias_method :original_calculate, :calculate
  def calculate(operation, column_name)
    if slavery_target == :slave
      Slavery.on_slave { original_calculate(operation, column_name) }
    else
      original_calculate(operation, column_name)
    end
  end
end
