/// Update an existing ingress-type bridge.
pub const UpdateIngressGatewayBridgeRequest = struct {
    /// The maximum expected bitrate (in bps).
    max_bitrate: ?i32,

    /// The maximum number of expected outputs.
    max_outputs: ?i32,

    pub const json_field_names = .{
        .max_bitrate = "MaxBitrate",
        .max_outputs = "MaxOutputs",
    };
};
