const Alarm = @import("alarm.zig").Alarm;

/// Automatic rollback configuration for handling endpoint deployment failures
/// and recovery.
pub const AutoRollbackConfig = struct {
    /// List of CloudWatch alarms in your account that are configured to monitor
    /// metrics on an endpoint. If any alarms are tripped during a deployment,
    /// SageMaker rolls back the deployment.
    alarms: ?[]const Alarm = null,

    pub const json_field_names = .{
        .alarms = "Alarms",
    };
};
