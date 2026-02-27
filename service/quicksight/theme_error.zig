const ThemeErrorType = @import("theme_error_type.zig").ThemeErrorType;

/// Theme error.
pub const ThemeError = struct {
    /// The error message.
    message: ?[]const u8,

    /// The type of error.
    type: ?ThemeErrorType,

    pub const json_field_names = .{
        .message = "Message",
        .type = "Type",
    };
};
