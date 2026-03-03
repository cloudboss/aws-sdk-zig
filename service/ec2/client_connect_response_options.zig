const ClientVpnEndpointAttributeStatus = @import("client_vpn_endpoint_attribute_status.zig").ClientVpnEndpointAttributeStatus;

/// The options for managing connection authorization for new client
/// connections.
pub const ClientConnectResponseOptions = struct {
    /// Indicates whether client connect options are enabled.
    enabled: ?bool = null,

    /// The Amazon Resource Name (ARN) of the Lambda function used for connection
    /// authorization.
    lambda_function_arn: ?[]const u8 = null,

    /// The status of any updates to the client connect options.
    status: ?ClientVpnEndpointAttributeStatus = null,
};
