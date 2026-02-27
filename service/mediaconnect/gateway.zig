const MessageDetail = @import("message_detail.zig").MessageDetail;
const GatewayState = @import("gateway_state.zig").GatewayState;
const GatewayNetwork = @import("gateway_network.zig").GatewayNetwork;

/// The settings for a gateway, including its networks.
pub const Gateway = struct {
    /// The range of IP addresses that contribute content or initiate output
    /// requests for flows communicating with this gateway. These IP addresses
    /// should be in the form of a Classless Inter-Domain Routing (CIDR) block; for
    /// example, 10.0.0.0/16.
    egress_cidr_blocks: []const []const u8,

    /// The Amazon Resource Name (ARN) of the gateway.
    gateway_arn: []const u8,

    /// Messages with information about the gateway.
    gateway_messages: ?[]const MessageDetail,

    /// The current status of the gateway.
    gateway_state: ?GatewayState,

    /// The name of the gateway. This name can not be modified after the gateway is
    /// created.
    name: []const u8,

    /// The list of networks in the gateway.
    networks: []const GatewayNetwork,

    pub const json_field_names = .{
        .egress_cidr_blocks = "EgressCidrBlocks",
        .gateway_arn = "GatewayArn",
        .gateway_messages = "GatewayMessages",
        .gateway_state = "GatewayState",
        .name = "Name",
        .networks = "Networks",
    };
};
