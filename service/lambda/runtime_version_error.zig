/// Any error returned when the runtime version information for the function
/// could not be retrieved.
pub const RuntimeVersionError = struct {
    /// The error code.
    error_code: ?[]const u8,

    /// The error message.
    message: ?[]const u8,
};
