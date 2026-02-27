pub const ClusterKubernetesTaintEffect = enum {
    no_schedule,
    prefer_no_schedule,
    no_execute,

    pub const json_field_names = .{
        .no_schedule = "NO_SCHEDULE",
        .prefer_no_schedule = "PREFER_NO_SCHEDULE",
        .no_execute = "NO_EXECUTE",
    };
};
