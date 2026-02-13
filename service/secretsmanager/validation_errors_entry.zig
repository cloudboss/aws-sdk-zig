/// Displays errors that occurred during validation of the resource policy.
pub const ValidationErrorsEntry = struct {
    /// Checks the name of the policy.
    check_name: ?[]const u8,

    /// Displays error messages if validation encounters problems during validation
    /// of the
    /// resource policy.
    error_message: ?[]const u8,

    pub const json_field_names = .{
        .check_name = "CheckName",
        .error_message = "ErrorMessage",
    };
};
