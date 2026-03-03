const ForwardErrorCorrectionState = @import("forward_error_correction_state.zig").ForwardErrorCorrectionState;

/// The configuration settings for a Router Input using the RTP (Real-Time
/// Transport Protocol) protocol, including the port and forward error
/// correction state.
pub const RtpRouterInputConfiguration = struct {
    /// The state of forward error correction for the RTP protocol in the router
    /// input configuration.
    forward_error_correction: ?ForwardErrorCorrectionState = null,

    /// The port number used for the RTP protocol in the router input configuration.
    port: i32,

    pub const json_field_names = .{
        .forward_error_correction = "ForwardErrorCorrection",
        .port = "Port",
    };
};
