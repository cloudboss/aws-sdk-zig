/// Information about the client connection logging options for a Client VPN
/// endpoint.
pub const ConnectionLogResponseOptions = struct {
    /// The name of the Amazon CloudWatch Logs log group to which connection logging
    /// data is published.
    cloudwatch_log_group: ?[]const u8,

    /// The name of the Amazon CloudWatch Logs log stream to which connection
    /// logging data is published.
    cloudwatch_log_stream: ?[]const u8,

    /// Indicates whether client connection logging is enabled for the Client VPN
    /// endpoint.
    enabled: ?bool,
};
