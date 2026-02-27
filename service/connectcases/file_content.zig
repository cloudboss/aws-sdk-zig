/// An object that represents a content of an Amazon Connect file object.
pub const FileContent = struct {
    /// The Amazon Resource Name (ARN) of a File in Amazon Connect.
    file_arn: []const u8,

    pub const json_field_names = .{
        .file_arn = "fileArn",
    };
};
