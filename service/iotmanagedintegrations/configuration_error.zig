/// Provides the default encryption configuration error update details.
pub const ConfigurationError = struct {
    /// The error code returned when the default encryption configuration update
    /// fails.
    code: ?[]const u8 = null,

    /// The error message returned when the default encryption configuration update
    /// fails.
    message: ?[]const u8 = null,

    pub const json_field_names = .{
        .code = "code",
        .message = "message",
    };
};
