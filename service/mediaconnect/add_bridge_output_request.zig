const AddBridgeNetworkOutputRequest = @import("add_bridge_network_output_request.zig").AddBridgeNetworkOutputRequest;

/// Add outputs to the specified bridge.
pub const AddBridgeOutputRequest = struct {
    /// The network output of the bridge. A network output is delivered to your
    /// premises.
    network_output: ?AddBridgeNetworkOutputRequest = null,

    pub const json_field_names = .{
        .network_output = "NetworkOutput",
    };
};
