/// The input failed to meet the constraints specified by Amazon Q Business in a
/// specified field.
pub const ValidationExceptionField = struct {
    /// A message about the validation exception.
    message: []const u8,

    /// The field name where the invalid entry was detected.
    name: []const u8,

    pub const json_field_names = .{
        .message = "message",
        .name = "name",
    };
};
