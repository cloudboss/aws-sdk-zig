const BrokerLogs = @import("broker_logs.zig").BrokerLogs;

pub const LoggingInfo = struct {
    broker_logs: BrokerLogs,

    pub const json_field_names = .{
        .broker_logs = "BrokerLogs",
    };
};
