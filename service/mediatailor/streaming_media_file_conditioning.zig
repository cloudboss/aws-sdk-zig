pub const StreamingMediaFileConditioning = enum {
    transcode,
    none,

    pub const json_field_names = .{
        .transcode = "TRANSCODE",
        .none = "NONE",
    };
};
