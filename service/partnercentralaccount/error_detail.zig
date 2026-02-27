const ProfileValidationErrorReason = @import("profile_validation_error_reason.zig").ProfileValidationErrorReason;

/// Contains detailed information about an error that occurred during an
/// operation.
pub const ErrorDetail = struct {
    /// The locale or language code for the error message.
    locale: []const u8,

    /// A human-readable description of the error.
    message: []const u8,

    /// A machine-readable code or reason for the error.
    reason: ProfileValidationErrorReason,

    pub const json_field_names = .{
        .locale = "Locale",
        .message = "Message",
        .reason = "Reason",
    };
};
