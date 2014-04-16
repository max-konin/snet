class Station
    include Neo4j::ActiveNode
    include Coordinates

    property :name, type: String
    property :permissible_load, type: Integer
    property :job_id, type: Integer
end