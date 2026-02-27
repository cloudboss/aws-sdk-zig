/// The input failed to meet the constraints specified by the Amazon Web
/// Services service in a specified field.
pub const ValidationExceptionDetail = struct {
    /// The field name where the invalid entry was detected.
    field_name: []const u8,

    /// A message with the reason for the validation exception error.
    message: []const u8,

    pub const json_field_names = .{
        .field_name = "fieldName",
        .message = "message",
    };
};
