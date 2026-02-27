pub const FeatureType = enum {
    integral,
    fractional,
    string,

    pub const json_field_names = .{
        .integral = "INTEGRAL",
        .fractional = "FRACTIONAL",
        .string = "STRING",
    };
};
