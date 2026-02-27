/// Create a bridge with the egress bridge type. An egress bridge is a
/// cloud-to-ground bridge. The content comes from an existing MediaConnect flow
/// and is delivered to your premises.
pub const AddEgressGatewayBridgeRequest = struct {
    /// The maximum expected bitrate (in bps) of the egress bridge.
    max_bitrate: i32,

    pub const json_field_names = .{
        .max_bitrate = "MaxBitrate",
    };
};
