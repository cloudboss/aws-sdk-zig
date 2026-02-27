pub const PropertyUsage = enum {
    inherit,
    dimension,
    measure,

    pub const json_field_names = .{
        .inherit = "INHERIT",
        .dimension = "DIMENSION",
        .measure = "MEASURE",
    };
};
