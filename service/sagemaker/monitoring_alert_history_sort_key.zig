pub const MonitoringAlertHistorySortKey = enum {
    creation_time,
    status,

    pub const json_field_names = .{
        .creation_time = "CreationTime",
        .status = "Status",
    };
};
