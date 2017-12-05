require_relative 'graph'

# Implementing topological sort using both Khan's and Tarian's algorithms

def topological_sort(vertices)
  sorted = []
  queue = []

  vertices.each do |vertex|
    queue << vertex if vertex.in_edges.empty?
  end

  until queue.empty?
    vertex = queue.shift
    sorted << vertex
    (vertex.out_edges.length - 1).downto(0) do |i|
      child = vertex.out_edges[i].to_vertex
      queue << child if child.in_edges.length == 1
      vertex.out_edges[i].destroy!
    end
  end
  vertices.length == sorted.length ? sorted : []
end
