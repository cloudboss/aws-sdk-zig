pub const StreamMode = enum {
    provisioned,
    on_demand,

    pub const json_field_names = .{
        .provisioned = "PROVISIONED",
        .on_demand = "ON_DEMAND",
    };
};
