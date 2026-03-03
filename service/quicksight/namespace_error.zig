const NamespaceErrorType = @import("namespace_error_type.zig").NamespaceErrorType;

/// Errors that occur during namespace creation.
pub const NamespaceError = struct {
    /// The message for the error.
    message: ?[]const u8 = null,

    /// The error type.
    @"type": ?NamespaceErrorType = null,

    pub const json_field_names = .{
        .message = "Message",
        .@"type" = "Type",
    };
};
