pub const MonitorCapability = enum {
    silent_monitor,
    barge,

    pub const json_field_names = .{
        .silent_monitor = "SILENT_MONITOR",
        .barge = "BARGE",
    };
};
