pub const RouteDirection = enum {
    east,
    north,
    south,
    west,

    pub const json_field_names = .{
        .east = "EAST",
        .north = "NORTH",
        .south = "SOUTH",
        .west = "WEST",
    };
};
