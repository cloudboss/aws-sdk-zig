/// The monitoring for an Amazon EC2 instance.
pub const AwsEc2LaunchTemplateDataMonitoringDetails = struct {
    /// Enables detailed monitoring when `true` is specified. Otherwise, basic
    /// monitoring is enabled.
    /// For more information about detailed monitoring, see
    /// [Enable or turn off detailed monitoring for your
    /// instances](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/using-cloudwatch-new.html) in the *Amazon EC2 User Guide*.
    enabled: ?bool = null,

    pub const json_field_names = .{
        .enabled = "Enabled",
    };
};
