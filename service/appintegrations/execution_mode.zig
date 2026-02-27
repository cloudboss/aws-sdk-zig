pub const ExecutionMode = enum {
    on_demand,
    scheduled,

    pub const json_field_names = .{
        .on_demand = "ON_DEMAND",
        .scheduled = "SCHEDULED",
    };
};
