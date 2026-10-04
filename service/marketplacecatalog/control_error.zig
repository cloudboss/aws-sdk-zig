const ErrorScope = @import("error_scope.zig").ErrorScope;

/// An error reported during the evaluation of a single control.
pub const ControlError = struct {
    /// The error code that identifies the type of error.
    code: ?[]const u8 = null,

    /// The message for the error.
    message: ?[]const u8 = null,

    /// The list of name-value pairs that identify the resource or attribute that
    /// the error
    /// applies to.
    scope: ?[]const ErrorScope = null,

    pub const json_field_names = .{
        .code = "Code",
        .message = "Message",
        .scope = "Scope",
    };
};
