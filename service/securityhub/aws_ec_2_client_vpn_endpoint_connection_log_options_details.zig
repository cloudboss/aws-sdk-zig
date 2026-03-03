/// Information about the client connection logging options for the Client VPN
/// endpoint.
pub const AwsEc2ClientVpnEndpointConnectionLogOptionsDetails = struct {
    /// The name of the Amazon CloudWatch Logs log group to which connection logging
    /// data is published.
    cloudwatch_log_group: ?[]const u8 = null,

    /// The name of the Amazon CloudWatch Logs log stream to which connection
    /// logging data is published.
    cloudwatch_log_stream: ?[]const u8 = null,

    /// Indicates whether client connection logging is enabled for the Client VPN
    /// endpoint.
    enabled: ?bool = null,

    pub const json_field_names = .{
        .cloudwatch_log_group = "CloudwatchLogGroup",
        .cloudwatch_log_stream = "CloudwatchLogStream",
        .enabled = "Enabled",
    };
};
