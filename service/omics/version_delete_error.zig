/// The error preventing deletion of the annotation store version.
pub const VersionDeleteError = struct {
    /// The message explaining the error in annotation store deletion.
    message: []const u8,

    /// The name given to an annotation store version.
    version_name: []const u8,

    pub const json_field_names = .{
        .message = "message",
        .version_name = "versionName",
    };
};
