pub const MonitoringExecutionSortKey = enum {
    creation_time,
    scheduled_time,
    status,

    pub const json_field_names = .{
        .creation_time = "CREATION_TIME",
        .scheduled_time = "SCHEDULED_TIME",
        .status = "STATUS",
    };
};
