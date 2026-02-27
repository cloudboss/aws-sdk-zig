const MessageDetail = @import("message_detail.zig").MessageDetail;
const BridgeState = @import("bridge_state.zig").BridgeState;
const EgressGatewayBridge = @import("egress_gateway_bridge.zig").EgressGatewayBridge;
const IngressGatewayBridge = @import("ingress_gateway_bridge.zig").IngressGatewayBridge;
const BridgeOutput = @import("bridge_output.zig").BridgeOutput;
const FailoverConfig = @import("failover_config.zig").FailoverConfig;
const BridgeSource = @import("bridge_source.zig").BridgeSource;

/// A Bridge is the connection between your data center's Instances and the
/// Amazon Web Services cloud. A bridge can be used to send video from the
/// Amazon Web Services cloud to your data center or from your data center to
/// the Amazon Web Services cloud.
pub const Bridge = struct {
    /// The Amazon Resource Number (ARN) of the bridge.
    bridge_arn: []const u8,

    /// Messages with details about the bridge.
    bridge_messages: ?[]const MessageDetail,

    /// The state of the bridge.
    bridge_state: BridgeState,

    /// An egress bridge is a cloud-to-ground bridge. The content comes from an
    /// existing MediaConnect flow and is delivered to your premises.
    egress_gateway_bridge: ?EgressGatewayBridge,

    /// An ingress bridge is a ground-to-cloud bridge. The content originates at
    /// your premises and is delivered to the cloud.
    ingress_gateway_bridge: ?IngressGatewayBridge,

    /// The name of the bridge.
    name: []const u8,

    /// The outputs on this bridge.
    outputs: ?[]const BridgeOutput,

    /// The placement Amazon Resource Number (ARN) of the bridge.
    placement_arn: []const u8,

    /// The settings for source failover.
    source_failover_config: ?FailoverConfig,

    /// The sources on this bridge.
    sources: ?[]const BridgeSource,

    pub const json_field_names = .{
        .bridge_arn = "BridgeArn",
        .bridge_messages = "BridgeMessages",
        .bridge_state = "BridgeState",
        .egress_gateway_bridge = "EgressGatewayBridge",
        .ingress_gateway_bridge = "IngressGatewayBridge",
        .name = "Name",
        .outputs = "Outputs",
        .placement_arn = "PlacementArn",
        .source_failover_config = "SourceFailoverConfig",
        .sources = "Sources",
    };
};
