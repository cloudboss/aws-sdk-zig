pub const TrackType = enum {
    video,
    audio,
    data,

    pub const json_field_names = .{
        .video = "video",
        .audio = "audio",
        .data = "data",
    };
};
