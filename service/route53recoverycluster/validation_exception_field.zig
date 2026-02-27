/// There was a validation error on the request.
pub const ValidationExceptionField = struct {
    /// Information about the validation exception.
    message: []const u8,

    /// The field that had the validation exception.
    name: []const u8,

    pub const json_field_names = .{
        .message = "message",
        .name = "name",
    };
};
