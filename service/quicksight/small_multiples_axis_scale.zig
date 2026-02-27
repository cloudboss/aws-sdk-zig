pub const SmallMultiplesAxisScale = enum {
    shared,
    independent,

    pub const json_field_names = .{
        .shared = "SHARED",
        .independent = "INDEPENDENT",
    };
};
