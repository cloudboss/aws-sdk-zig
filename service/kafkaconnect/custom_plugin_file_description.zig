/// Details about a custom plugin file.
pub const CustomPluginFileDescription = struct {
    /// The hex-encoded MD5 checksum of the custom plugin file. You can use it to
    /// validate the file.
    file_md_5: ?[]const u8,

    /// The size in bytes of the custom plugin file. You can use it to validate the
    /// file.
    file_size: i64 = 0,

    pub const json_field_names = .{
        .file_md_5 = "fileMd5",
        .file_size = "fileSize",
    };
};
