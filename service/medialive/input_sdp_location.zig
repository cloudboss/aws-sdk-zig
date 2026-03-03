/// The location of the SDP file for one of the SMPTE 2110 streams in a receiver
/// group.
pub const InputSdpLocation = struct {
    /// The index of the media stream in the SDP file for one SMPTE 2110 stream.
    media_index: ?i32 = null,

    /// The URL of the SDP file for one SMPTE 2110 stream.
    sdp_url: ?[]const u8 = null,

    pub const json_field_names = .{
        .media_index = "MediaIndex",
        .sdp_url = "SdpUrl",
    };
};
