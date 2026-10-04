/// Contains details about an error that occurred when Lambda attempted to
/// retrieve a function's deployment package.
pub const FunctionCodeLocationError = struct {
    /// The error code that identifies why Lambda failed to retrieve the deployment
    /// package.
    error_code: ?[]const u8 = null,

    /// The human-readable message that describes why Lambda failed to retrieve the
    /// deployment package.
    message: ?[]const u8 = null,

    pub const json_field_names = .{
        .error_code = "ErrorCode",
        .message = "Message",
    };
};
