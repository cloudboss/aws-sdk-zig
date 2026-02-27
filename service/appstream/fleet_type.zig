pub const FleetType = enum {
    always_on,
    on_demand,
    elastic,

    pub const json_field_names = .{
        .always_on = "ALWAYS_ON",
        .on_demand = "ON_DEMAND",
        .elastic = "ELASTIC",
    };
};
