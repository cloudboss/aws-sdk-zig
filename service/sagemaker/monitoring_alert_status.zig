pub const MonitoringAlertStatus = enum {
    in_alert,
    ok,

    pub const json_field_names = .{
        .in_alert = "IN_ALERT",
        .ok = "OK",
    };
};
