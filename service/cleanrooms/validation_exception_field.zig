/// Describes validation errors for specific input parameters.
pub const ValidationExceptionField = struct {
    /// A message for the input validation error.
    message: []const u8,

    /// The name of the input parameter.
    name: []const u8,

    pub const json_field_names = .{
        .message = "message",
        .name = "name",
    };
};
