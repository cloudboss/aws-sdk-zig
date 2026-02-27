pub const GuardrailImageFormat = enum {
    png,
    jpeg,

    pub const json_field_names = .{
        .png = "PNG",
        .jpeg = "JPEG",
    };
};
