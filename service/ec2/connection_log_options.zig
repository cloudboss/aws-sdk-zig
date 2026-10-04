/// Describes the client connection logging options for the Client VPN endpoint.
pub const ConnectionLogOptions = struct {
    /// The name of the CloudWatch Logs log group. Required if connection logging is
    /// enabled.
    cloudwatch_log_group: ?[]const u8 = null,

    /// The name of the CloudWatch Logs log stream to which the connection data is
    /// published.
    cloudwatch_log_stream: ?[]const u8 = null,

    /// Indicates whether connection logging is enabled.
    enabled: ?bool = null,

    /// Specifies whether to include the authorization policy evaluation context in
    /// the connection logs for the Client VPN endpoint.
    include_authorization_policy_context: ?bool = null,
};
