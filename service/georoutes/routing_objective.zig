pub const RoutingObjective = enum {
    fastest_route,
    shortest_route,

    pub const json_field_names = .{
        .fastest_route = "FASTEST_ROUTE",
        .shortest_route = "SHORTEST_ROUTE",
    };
};
