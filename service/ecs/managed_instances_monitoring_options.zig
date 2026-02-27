pub const ManagedInstancesMonitoringOptions = enum {
    basic,
    detailed,

    pub const json_field_names = .{
        .basic = "BASIC",
        .detailed = "DETAILED",
    };
};
