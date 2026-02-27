const LogType = @import("log_type.zig").LogType;

/// An object representing the enabled or disabled Kubernetes control plane logs
/// for your
/// cluster.
pub const LogSetup = struct {
    /// If a log type is enabled, that log type exports its control plane logs to
    /// CloudWatch Logs . If a
    /// log type isn't enabled, that log type doesn't export its control plane logs.
    /// Each
    /// individual log type can be enabled or disabled independently.
    enabled: ?bool,

    /// The available cluster control plane log types.
    types: ?[]const LogType,

    pub const json_field_names = .{
        .enabled = "enabled",
        .types = "types",
    };
};
