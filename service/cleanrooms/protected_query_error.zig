/// Details of errors thrown by the protected query.
pub const ProtectedQueryError = struct {
    /// An error code for the error.
    code: []const u8,

    /// A description of why the query failed.
    message: []const u8,

    pub const json_field_names = .{
        .code = "code",
        .message = "message",
    };
};
