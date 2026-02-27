pub const Direction = enum {
    both,
    ascendants,
    descendants,

    pub const json_field_names = .{
        .both = "BOTH",
        .ascendants = "ASCENDANTS",
        .descendants = "DESCENDANTS",
    };
};
