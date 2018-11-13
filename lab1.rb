require 'matrix'
require 'pry'
require 'csv'


class Lab1
  A = 0
  B = 1
  C = 2
  D = 3

  @graph = Matrix[[0, 20, 42, 35],
                  [20, 0, 30, 34],
                  [42, 30, 0, 12],
                  [35, 34, 12, 0]]

  def self.get_cost_of_route(route)
    count = 0

    route.each_index do |index|
      current = route[index]
      next_e = route[index + 1]

      count += @graph[current, next_e.to_i]

      # binding.pry

      # puts "#{current} to #{next_e.to_i} and count is #{count}"
    end

    count
  end

  def self.generate_routes
    cities = [A, B, C, D]
    random_cities = cities.shuffle
    get_cost_of_route(random_cities)
  end

  def self.random_search_time_based(route, time_limit)
    shortest_route = []
    limit = Time.now + time_limit
    while Time.now < limit
      random_cities1 = route.shuffle
      random_cities2 = route.shuffle

      random_route1 = get_cost_of_route(random_cities1)
      random_route2 = get_cost_of_route(random_cities2)

      cost = [random_route1, random_route2]

      shortest_route.push(cost.min)

      puts "RR1 #{random_route1} RR2 #{random_route2} SR #{shortest_route}"

      sleep 1
    end
    puts "The shortest route with the time limit #{time_limit} is #{shortest_route.min}"
  end

  def self.two_opt_neighbourhood(route)
    random_route = route.shuffle

  end

  def self.csv_problem_instance
    results = []
    # path = File.dirname('/Users/adeelahmed/RubymineProjects/Lab1/ulysses16.csv')
    # puts path
    # locations = CSV.read('/Users/adeelahmed/RubymineProjects/Lab1/ulysses16.csv')
    # puts location

    csv_table = CSV.read('/Users/adeelahmed/RubymineProjects/Lab1/ulysses16.csv', headers: true)
    # @graph = Matrix.rows(@graph.to_a << [1,2,3,4])
    # puts @graph
    # euclid(row[1],row)

    @csv_array = csv_table.to_a
    count = 1
    @csv_array.each_index do |index|
      last_city = @csv_array.last[0].to_i
      first_city_index = index + 2
      second_city_index = first_city_index + 1


      first_city = @csv_array[first_city_index]
      second_city = @csv_array[second_city_index]

      a_x = first_city[1].to_f
      b_x = second_city[1].to_f
      a_y = first_city[2].to_f
      b_y = second_city[2].to_f

      count = count + 1
      result = euclid(a_x, b_x, a_y, b_y)
      # puts result
      results.push(result)


      if count == last_city
        original_city = @csv_array[2]
        latest_city = @csv_array[count + 1]
        back_home = euclid(latest_city[1].to_f,
                           original_city[1].to_f,
                           latest_city[2].to_f,
                           original_city[2].to_f)
        # binding.pry

        results.push(back_home)

        break
      end
    end
    results


  end

  # generate_routes

  # route1 = [A, C, B, D]
  # get_cost_of_route(route1)

  # def self.csv_matrix
  #   matrix = csv_problem_instance
  #
  #   matrix.each do |element|
  #
  #   end
  #
  #   # @graph = Matrix.rows(@graph.to_a << [1,2,3,4])
  #   # csv_matrix = Matrix.rows(csv_matrix << matrix)
  #
  #
  #   # csv_matrix = Matrix.build(csv_problem_instance.length) {csv_problem_instance.each {|e|  e}}
  # end

  def self.euclid(x_city_a, x_city_b, y_city_a, y_city_b)
    first_brackets = (x_city_b - x_city_a) ** 2
    # puts first_brackets

    second_brackets = (y_city_b - y_city_a) ** 2
    # puts second_brackets

    addition = first_brackets + second_brackets
    # puts addition
    Math.sqrt(addition)

  end

  random_search_time_based([A, B, C, D], 20)

  # csv_matrix


end
