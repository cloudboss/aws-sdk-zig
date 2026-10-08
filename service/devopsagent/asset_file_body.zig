/// Content of an individual asset file
pub const AssetFileBody = union(enum) {
    bytes: ?[]const u8,
    text: ?[]const u8,

    pub const json_field_names = .{
        .bytes = "bytes",
        .text = "text",
    };
};
