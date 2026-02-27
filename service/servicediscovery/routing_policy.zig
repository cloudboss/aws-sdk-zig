pub const RoutingPolicy = enum {
    multivalue,
    weighted,

    pub const json_field_names = .{
        .multivalue = "MULTIVALUE",
        .weighted = "WEIGHTED",
    };
};
