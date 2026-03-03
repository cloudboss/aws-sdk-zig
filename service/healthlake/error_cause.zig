const ErrorCategory = @import("error_category.zig").ErrorCategory;

/// The error information for `CreateFHIRDatastore` and
/// `DeleteFHIRDatastore` actions.
pub const ErrorCause = struct {
    /// The error category for `ErrorCause`.
    error_category: ?ErrorCategory = null,

    /// The error message text for `ErrorCause`.
    error_message: ?[]const u8 = null,

    pub const json_field_names = .{
        .error_category = "ErrorCategory",
        .error_message = "ErrorMessage",
    };
};
