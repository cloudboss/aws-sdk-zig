/// Represents a validation error field in an API request.
pub const ValidationExceptionField = struct {
    /// Detailed error message describing the validation issue.
    message: []const u8,

    /// Name of the field that failed validation.
    name: []const u8,

    /// Reason for the validation failure.
    reason: []const u8,

    pub const json_field_names = .{
        .message = "Message",
        .name = "Name",
        .reason = "Reason",
    };
};
