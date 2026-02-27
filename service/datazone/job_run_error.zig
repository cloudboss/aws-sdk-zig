/// The job run error.
pub const JobRunError = struct {
    /// The job run error message.
    message: []const u8,

    pub const json_field_names = .{
        .message = "message",
    };
};
