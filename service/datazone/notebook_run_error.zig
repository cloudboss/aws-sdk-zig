/// The error details of a failed notebook run in Amazon DataZone.
pub const NotebookRunError = struct {
    /// The error message. The maximum length is 1024 characters.
    message: []const u8,

    pub const json_field_names = .{
        .message = "message",
    };
};
