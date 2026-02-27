/// Create a bridge with the ingress bridge type. An ingress bridge is a
/// ground-to-cloud bridge. The content originates at your premises and is
/// delivered to the cloud.
pub const IngressGatewayBridge = struct {
    /// The ID of the instance running this bridge.
    instance_id: ?[]const u8,

    /// The maximum expected bitrate (in bps) of the ingress bridge.
    max_bitrate: i32,

    /// The maximum number of outputs on the ingress bridge.
    max_outputs: i32,

    pub const json_field_names = .{
        .instance_id = "InstanceId",
        .max_bitrate = "MaxBitrate",
        .max_outputs = "MaxOutputs",
    };
};
