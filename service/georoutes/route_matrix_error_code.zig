pub const RouteMatrixErrorCode = enum {
    no_match,
    no_match_destination,
    no_match_origin,
    no_route,
    out_of_bounds,
    out_of_bounds_destination,
    out_of_bounds_origin,
    other,
    violation,

    pub const json_field_names = .{
        .no_match = "NO_MATCH",
        .no_match_destination = "NO_MATCH_DESTINATION",
        .no_match_origin = "NO_MATCH_ORIGIN",
        .no_route = "NO_ROUTE",
        .out_of_bounds = "OUT_OF_BOUNDS",
        .out_of_bounds_destination = "OUT_OF_BOUNDS_DESTINATION",
        .out_of_bounds_origin = "OUT_OF_BOUNDS_ORIGIN",
        .other = "OTHER",
        .violation = "VIOLATION",
    };
};
