const AddBridgeFlowSourceRequest = @import("add_bridge_flow_source_request.zig").AddBridgeFlowSourceRequest;
const AddBridgeNetworkSourceRequest = @import("add_bridge_network_source_request.zig").AddBridgeNetworkSourceRequest;

/// Add an output to a bridge.
pub const AddBridgeSourceRequest = struct {
    /// The source of the flow.
    flow_source: ?AddBridgeFlowSourceRequest = null,

    /// The source of the network.
    network_source: ?AddBridgeNetworkSourceRequest = null,

    pub const json_field_names = .{
        .flow_source = "FlowSource",
        .network_source = "NetworkSource",
    };
};
