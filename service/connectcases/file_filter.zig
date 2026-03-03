/// A filter for related items of type `File`.
pub const FileFilter = struct {
    /// The Amazon Resource Name (ARN) of the file.
    file_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .file_arn = "fileArn",
    };
};
