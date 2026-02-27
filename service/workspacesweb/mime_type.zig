pub const MimeType = enum {
    png,
    jpeg,
    ico,

    pub const json_field_names = .{
        .png = "PNG",
        .jpeg = "JPEG",
        .ico = "ICO",
    };
};
