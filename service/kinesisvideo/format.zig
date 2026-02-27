pub const Format = enum {
    jpeg,
    png,

    pub const json_field_names = .{
        .jpeg = "JPEG",
        .png = "PNG",
    };
};
