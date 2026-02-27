pub const DimensionUnit = enum {
    meters,
    feet,

    pub const json_field_names = .{
        .meters = "Meters",
        .feet = "Feet",
    };
};
