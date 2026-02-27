pub const CustomContentType = enum {
    image,
    other_embedded_content,

    pub const json_field_names = .{
        .image = "IMAGE",
        .other_embedded_content = "OTHER_EMBEDDED_CONTENT",
    };
};
