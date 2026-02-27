/// The protected job error.
pub const ProtectedJobError = struct {
    /// The error code for the protected job.
    code: []const u8,

    /// The message for the protected job error.
    message: []const u8,

    pub const json_field_names = .{
        .code = "code",
        .message = "message",
    };
};
