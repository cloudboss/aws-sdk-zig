const EncodingProfile = @import("encoding_profile.zig").EncodingProfile;

/// The encoding configuration to apply to the NDI® source when transcoding it
/// to a transport stream for downstream distribution. You can choose between
/// several predefined encoding profiles based on common use cases.
pub const EncodingConfig = struct {
    /// The encoding profile to use when transcoding the NDI source content to a
    /// transport stream. You can change this value while the flow is running.
    encoding_profile: ?EncodingProfile,

    /// The maximum video bitrate to use when transcoding the NDI source to a
    /// transport stream. This parameter enables you to override the default video
    /// bitrate within the encoding profile's supported range.
    ///
    /// The supported range is 10,000,000 - 50,000,000 bits per second (bps). If you
    /// don't specify a value, MediaConnect uses the default value of 20,000,000
    /// bps.
    video_max_bitrate: ?i32,

    pub const json_field_names = .{
        .encoding_profile = "EncodingProfile",
        .video_max_bitrate = "VideoMaxBitrate",
    };
};
