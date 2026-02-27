const BridgeFlowSource = @import("bridge_flow_source.zig").BridgeFlowSource;
const BridgeNetworkSource = @import("bridge_network_source.zig").BridgeNetworkSource;

/// The bridge's source.
pub const BridgeSource = struct {
    /// The source of the associated flow.
    flow_source: ?BridgeFlowSource,

    /// The network source for the bridge.
    network_source: ?BridgeNetworkSource,

    pub const json_field_names = .{
        .flow_source = "FlowSource",
        .network_source = "NetworkSource",
    };
};
