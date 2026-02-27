const BridgeFlowOutput = @import("bridge_flow_output.zig").BridgeFlowOutput;
const BridgeNetworkOutput = @import("bridge_network_output.zig").BridgeNetworkOutput;

/// The output of the bridge.
pub const BridgeOutput = struct {
    /// The output of the associated flow.
    flow_output: ?BridgeFlowOutput,

    /// The network output for the bridge.
    network_output: ?BridgeNetworkOutput,

    pub const json_field_names = .{
        .flow_output = "FlowOutput",
        .network_output = "NetworkOutput",
    };
};
