pub const JobRunMode = enum {
    scheduled,
    on_demand,

    pub const json_field_names = .{
        .scheduled = "SCHEDULED",
        .on_demand = "ON_DEMAND",
    };
};
