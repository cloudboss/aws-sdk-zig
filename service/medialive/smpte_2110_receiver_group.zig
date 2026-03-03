const Smpte2110ReceiverGroupSdpSettings = @import("smpte_2110_receiver_group_sdp_settings.zig").Smpte2110ReceiverGroupSdpSettings;

/// A receiver group is a collection of video, audio, and ancillary streams that
/// you want to group together and attach to one input.
pub const Smpte2110ReceiverGroup = struct {
    /// The single Smpte2110ReceiverGroupSdpSettings that identify the video, audio,
    /// and ancillary streams for this receiver group.
    sdp_settings: ?Smpte2110ReceiverGroupSdpSettings = null,

    pub const json_field_names = .{
        .sdp_settings = "SdpSettings",
    };
};
