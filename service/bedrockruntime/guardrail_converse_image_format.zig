pub const GuardrailConverseImageFormat = enum {
    png,
    jpeg,

    pub const json_field_names = .{
        .png = "PNG",
        .jpeg = "JPEG",
    };
};
