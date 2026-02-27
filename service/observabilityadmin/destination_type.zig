pub const DestinationType = enum {
    cloudwatch_logs,

    pub const json_field_names = .{
        .cloudwatch_logs = "CLOUDWATCH_LOGS",
    };
};
