/// Error response to `GetFunctionConfiguration`.
pub const ImageConfigError = struct {
    /// Error code.
    error_code: ?[]const u8,

    /// Error message.
    message: ?[]const u8,
};
