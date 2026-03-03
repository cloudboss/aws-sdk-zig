const InputSdpLocation = @import("input_sdp_location.zig").InputSdpLocation;

/// Information about the SDP files that describe the SMPTE 2110 streams that go
/// into one SMPTE 2110 receiver group.
pub const Smpte2110ReceiverGroupSdpSettings = struct {
    /// A list of InputSdpLocations. Each item in the list specifies the SDP file
    /// and index for one ancillary SMPTE 2110 stream.
    /// Each stream encapsulates one captions stream (out of any number you can
    /// include) or the single SCTE 35 stream that you can include.
    ancillary_sdps: ?[]const InputSdpLocation = null,

    /// A list of InputSdpLocations. Each item in the list specifies the SDP file
    /// and index for one audio SMPTE 2110 stream.
    audio_sdps: ?[]const InputSdpLocation = null,

    /// The InputSdpLocation that specifies the SDP file and index for the single
    /// video SMPTE 2110 stream for this 2110 input.
    video_sdp: ?InputSdpLocation = null,

    pub const json_field_names = .{
        .ancillary_sdps = "AncillarySdps",
        .audio_sdps = "AudioSdps",
        .video_sdp = "VideoSdp",
    };
};
