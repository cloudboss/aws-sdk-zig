pub const OptimizationMode = enum {
    fastest_route,
    shortest_route,

    pub const json_field_names = .{
        .fastest_route = "FastestRoute",
        .shortest_route = "ShortestRoute",
    };
};
