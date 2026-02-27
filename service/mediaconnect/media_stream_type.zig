pub const MediaStreamType = enum {
    video,
    audio,
    ancillary_data,

    pub const json_field_names = .{
        .video = "video",
        .audio = "audio",
        .ancillary_data = "ancillary_data",
    };
};
