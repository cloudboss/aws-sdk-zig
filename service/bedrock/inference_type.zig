pub const InferenceType = enum {
    on_demand,
    provisioned,

    pub const json_field_names = .{
        .on_demand = "ON_DEMAND",
        .provisioned = "PROVISIONED",
    };
};
