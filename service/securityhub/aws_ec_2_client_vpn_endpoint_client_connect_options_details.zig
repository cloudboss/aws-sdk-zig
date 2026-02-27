const AwsEc2ClientVpnEndpointClientConnectOptionsStatusDetails = @import("aws_ec_2_client_vpn_endpoint_client_connect_options_status_details.zig").AwsEc2ClientVpnEndpointClientConnectOptionsStatusDetails;

/// The options for managing connection authorization for new client
/// connections.
pub const AwsEc2ClientVpnEndpointClientConnectOptionsDetails = struct {
    /// Indicates whether client connect options are enabled.
    enabled: ?bool,

    /// The Amazon Resource Name (ARN) of the Lambda function used for connection
    /// authorization.
    lambda_function_arn: ?[]const u8,

    /// The status of any updates to the client connect options.
    status: ?AwsEc2ClientVpnEndpointClientConnectOptionsStatusDetails,

    pub const json_field_names = .{
        .enabled = "Enabled",
        .lambda_function_arn = "LambdaFunctionArn",
        .status = "Status",
    };
};
