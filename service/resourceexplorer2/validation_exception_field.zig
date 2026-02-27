/// A structure that describes a request field with a validation error.
pub const ValidationExceptionField = struct {
    /// The name of the request field that had a validation error.
    name: []const u8,

    /// The validation error caused by the request field.
    validation_issue: []const u8,

    pub const json_field_names = .{
        .name = "Name",
        .validation_issue = "ValidationIssue",
    };
};
