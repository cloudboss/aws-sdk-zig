/// The HTTP Accept header. Indicates the requested type fothe thumbnail.
pub const AcceptHeader = enum {
    image_jpeg,

    pub const json_field_names = .{
        .image_jpeg = "image_jpeg",
    };
};
