/// The type of monitoring that’s turned on for an Amazon EC2 instance.
pub const AwsEc2InstanceMonitoringDetails = struct {
    /// Indicates whether detailed monitoring is turned on. Otherwise, basic
    /// monitoring is turned on.
    state: ?[]const u8,

    pub const json_field_names = .{
        .state = "State",
    };
};
