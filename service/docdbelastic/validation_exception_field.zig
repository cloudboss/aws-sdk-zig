/// A specific field in which a given validation exception occurred.
pub const ValidationExceptionField = struct {
    /// An error message describing the validation exception in this field.
    message: []const u8,

    /// The name of the field where the validation exception occurred.
    name: []const u8,

    pub const json_field_names = .{
        .message = "message",
        .name = "name",
    };
};
