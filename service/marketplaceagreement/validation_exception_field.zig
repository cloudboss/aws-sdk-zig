/// The input fails to satisfy the constraints specified by the service.
pub const ValidationExceptionField = struct {
    /// See applicable actions.
    message: []const u8,

    /// The name of the field associated with the error.
    name: []const u8,

    pub const json_field_names = .{
        .message = "message",
        .name = "name",
    };
};
