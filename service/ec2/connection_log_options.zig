/// Describes the client connection logging options for the Client VPN endpoint.
pub const ConnectionLogOptions = struct {
    /// The name of the CloudWatch Logs log group. Required if connection logging is
    /// enabled.
    cloudwatch_log_group: ?[]const u8,

    /// The name of the CloudWatch Logs log stream to which the connection data is
    /// published.
    cloudwatch_log_stream: ?[]const u8,

    /// Indicates whether connection logging is enabled.
    enabled: ?bool,
};
