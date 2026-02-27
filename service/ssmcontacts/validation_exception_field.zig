/// Provides information about which field caused the exception.
pub const ValidationExceptionField = struct {
    /// Information about what caused the field to cause an exception.
    message: []const u8,

    /// The name of the field that caused the exception.
    name: []const u8,

    pub const json_field_names = .{
        .message = "Message",
        .name = "Name",
    };
};
