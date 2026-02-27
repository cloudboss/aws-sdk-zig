/// The field's information of a request that resulted in an exception.
pub const ValidationExceptionField = struct {
    /// The message describing why the field failed validation.
    message: []const u8,

    /// The field name.
    name: []const u8,

    pub const json_field_names = .{
        .message = "Message",
        .name = "Name",
    };
};
