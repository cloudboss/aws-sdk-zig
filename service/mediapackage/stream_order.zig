pub const StreamOrder = enum {
    original,
    video_bitrate_ascending,
    video_bitrate_descending,

    pub const json_field_names = .{
        .original = "ORIGINAL",
        .video_bitrate_ascending = "VIDEO_BITRATE_ASCENDING",
        .video_bitrate_descending = "VIDEO_BITRATE_DESCENDING",
    };
};
