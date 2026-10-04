const AuthorizerLogs = @import("authorizer_logs.zig").AuthorizerLogs;
const BrokerLogs = @import("broker_logs.zig").BrokerLogs;

pub const LoggingInfo = struct {
    /// You can configure your MSK cluster to send authorizer logs to different
    /// destination types.
    authorizer_logs: ?AuthorizerLogs = null,

    broker_logs: BrokerLogs,

    pub const json_field_names = .{
        .authorizer_logs = "AuthorizerLogs",
        .broker_logs = "BrokerLogs",
    };
};
