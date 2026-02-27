/// Specifies the media type of the thumbnail.
pub const ContentType = enum {
    image_jpeg,

    pub const json_field_names = .{
        .image_jpeg = "image_jpeg",
    };
};
