const HarnessGatewayOutboundAuth = @import("harness_gateway_outbound_auth.zig").HarnessGatewayOutboundAuth;

/// Configuration for AgentCore Gateway.
pub const HarnessAgentCoreGatewayConfig = struct {
    /// The ARN of the desired AgentCore Gateway.
    gateway_arn: []const u8,

    /// How Loopy authenticates to this Gateway. Defaults to AWS_IAM (SigV4) if
    /// omitted.
    outbound_auth: ?HarnessGatewayOutboundAuth = null,

    pub const json_field_names = .{
        .gateway_arn = "gatewayArn",
        .outbound_auth = "outboundAuth",
    };
};
