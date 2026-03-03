const ForwardErrorCorrectionState = @import("forward_error_correction_state.zig").ForwardErrorCorrectionState;

/// The configuration settings for a router output using the RTP (Real-Time
/// Transport Protocol) protocol, including the destination address and port,
/// and forward error correction state.
pub const RtpRouterOutputConfiguration = struct {
    /// The destination IP address for the RTP protocol in the router output
    /// configuration.
    destination_address: []const u8,

    /// The destination port number for the RTP protocol in the router output
    /// configuration.
    destination_port: i32,

    /// The state of forward error correction for the RTP protocol in the router
    /// output configuration.
    forward_error_correction: ?ForwardErrorCorrectionState = null,

    pub const json_field_names = .{
        .destination_address = "DestinationAddress",
        .destination_port = "DestinationPort",
        .forward_error_correction = "ForwardErrorCorrection",
    };
};
