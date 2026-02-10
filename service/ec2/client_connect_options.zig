/// The options for managing connection authorization for new client
/// connections.
pub const ClientConnectOptions = struct {
    /// Indicates whether client connect options are enabled. The default is `false`
    /// (not enabled).
    enabled: ?bool,

    /// The Amazon Resource Name (ARN) of the Lambda function used for connection
    /// authorization.
    lambda_function_arn: ?[]const u8,
};
