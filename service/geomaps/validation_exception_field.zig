/// The input fails to satisfy the constraints specified by the Amazon Location
/// service.
pub const ValidationExceptionField = struct {
    /// The error message.
    message: []const u8,

    /// The name of the resource.
    name: []const u8,

    pub const json_field_names = .{
        .message = "Message",
        .name = "Name",
    };
};
