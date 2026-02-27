pub const RotationType = enum {
    automatic,
    on_demand,

    pub const json_field_names = .{
        .automatic = "AUTOMATIC",
        .on_demand = "ON_DEMAND",
    };
};
