const InputLossActionForUdpOut = @import("input_loss_action_for_udp_out.zig").InputLossActionForUdpOut;

/// Srt Group Settings
pub const SrtGroupSettings = struct {
    /// Specifies behavior of last resort when input video is lost, and no more
    /// backup inputs are available. When dropTs is selected the entire transport
    /// stream will stop being emitted. When dropProgram is selected the program can
    /// be dropped from the transport stream (and replaced with null packets to meet
    /// the TS bitrate requirement). Or, when emitProgram is chosen the transport
    /// stream will continue to be produced normally with repeat frames, black
    /// frames, or slate frames substituted for the absent input video.
    input_loss_action: ?InputLossActionForUdpOut,

    pub const json_field_names = .{
        .input_loss_action = "InputLossAction",
    };
};
