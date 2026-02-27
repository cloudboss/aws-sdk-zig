/// A structure providing details of any failures that occurred.
pub const FileSystemFailureDetails = struct {
    /// A message describing any failures that occurred.
    message: ?[]const u8,

    pub const json_field_names = .{
        .message = "Message",
    };
};
