pub const MetricStreamOutputFormat = enum {
    json,
    open_telemetry_0_7,
    open_telemetry_1_0,

    pub const json_field_names = .{
        .json = "JSON",
        .open_telemetry_0_7 = "OPEN_TELEMETRY_0_7",
        .open_telemetry_1_0 = "OPEN_TELEMETRY_1_0",
    };
};
