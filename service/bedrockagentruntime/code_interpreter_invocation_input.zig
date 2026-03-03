/// Contains information about the code interpreter being invoked.
pub const CodeInterpreterInvocationInput = struct {
    /// The code for the code interpreter to use.
    code: ?[]const u8 = null,

    /// Files that are uploaded for code interpreter to use.
    files: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .code = "code",
        .files = "files",
    };
};
