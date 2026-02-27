/// Represents a field that failed validation in a request.
pub const ValidationExceptionField = struct {
    /// The error message describing why the field failed validation.
    message: []const u8,

    /// The name of the field that failed validation.
    name: []const u8,

    pub const json_field_names = .{
        .message = "message",
        .name = "name",
    };
};
