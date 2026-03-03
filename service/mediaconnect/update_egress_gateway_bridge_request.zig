/// Update an existing egress-type bridge.
pub const UpdateEgressGatewayBridgeRequest = struct {
    /// The maximum expected bitrate (in bps).
    max_bitrate: ?i32 = null,

    pub const json_field_names = .{
        .max_bitrate = "MaxBitrate",
    };
};
