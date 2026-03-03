const InputLossActionForUdpOut = @import("input_loss_action_for_udp_out.zig").InputLossActionForUdpOut;
const UdpTimedMetadataId3Frame = @import("udp_timed_metadata_id_3_frame.zig").UdpTimedMetadataId3Frame;

/// Udp Group Settings
pub const UdpGroupSettings = struct {
    /// Specifies behavior of last resort when input video is lost, and no more
    /// backup inputs are available. When dropTs is selected the entire transport
    /// stream will stop being emitted. When dropProgram is selected the program can
    /// be dropped from the transport stream (and replaced with null packets to meet
    /// the TS bitrate requirement). Or, when emitProgram is chosen the transport
    /// stream will continue to be produced normally with repeat frames, black
    /// frames, or slate frames substituted for the absent input video.
    input_loss_action: ?InputLossActionForUdpOut = null,

    /// Indicates ID3 frame that has the timecode.
    timed_metadata_id_3_frame: ?UdpTimedMetadataId3Frame = null,

    /// Timed Metadata interval in seconds.
    timed_metadata_id_3_period: ?i32 = null,

    pub const json_field_names = .{
        .input_loss_action = "InputLossAction",
        .timed_metadata_id_3_frame = "TimedMetadataId3Frame",
        .timed_metadata_id_3_period = "TimedMetadataId3Period",
    };
};
