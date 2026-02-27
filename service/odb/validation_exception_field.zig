/// The input failed to meet the constraints specified by the service in a
/// specified field. Make sure you provided the correct input and try again.
pub const ValidationExceptionField = struct {
    /// The description of the error.
    message: []const u8,

    /// The field name for which validation failed.
    name: []const u8,

    pub const json_field_names = .{
        .message = "message",
        .name = "name",
    };
};
