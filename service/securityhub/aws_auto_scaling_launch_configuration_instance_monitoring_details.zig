/// Information about the type of monitoring for instances in the group.
pub const AwsAutoScalingLaunchConfigurationInstanceMonitoringDetails = struct {
    /// If set to `true`, then instances in the group launch with detailed
    /// monitoring.
    ///
    /// If set to `false`, then instances in the group launch with basic
    /// monitoring.
    enabled: ?bool,

    pub const json_field_names = .{
        .enabled = "Enabled",
    };
};
