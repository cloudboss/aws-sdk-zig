/// Create a bridge with the ingress bridge type. An ingress bridge is a
/// ground-to-cloud bridge. The content originates at your premises and is
/// delivered to the cloud.
pub const AddIngressGatewayBridgeRequest = struct {
    /// The maximum expected bitrate (in bps) of the ingress bridge.
    max_bitrate: i32,

    /// The maximum number of expected outputs on the ingress bridge.
    max_outputs: i32,

    pub const json_field_names = .{
        .max_bitrate = "MaxBitrate",
        .max_outputs = "MaxOutputs",
    };
};
