/// Contains information about a field that failed validation, including the
/// field name and a descriptive error message.
pub const ValidationExceptionField = struct {
    /// A message that describes why the field failed validation.
    message: []const u8,

    /// The name of the field that failed validation.
    name: []const u8,

    pub const json_field_names = .{
        .message = "Message",
        .name = "Name",
    };
};
