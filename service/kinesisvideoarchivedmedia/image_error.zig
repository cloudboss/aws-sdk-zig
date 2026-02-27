pub const ImageError = enum {
    no_media,
    media_error,

    pub const json_field_names = .{
        .no_media = "NO_MEDIA",
        .media_error = "MEDIA_ERROR",
    };
};
