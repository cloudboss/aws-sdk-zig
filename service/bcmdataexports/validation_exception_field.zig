/// The input failed to meet the constraints specified by the Amazon Web
/// Services service in a
/// specified field.
pub const ValidationExceptionField = struct {
    /// A message with the reason for the validation exception error.
    message: []const u8,

    /// The field name where the invalid entry was detected.
    name: []const u8,

    pub const json_field_names = .{
        .message = "Message",
        .name = "Name",
    };
};
