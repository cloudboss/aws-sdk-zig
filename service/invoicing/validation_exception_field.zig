/// The input fails to satisfy the constraints specified by an Amazon Web
/// Services service.
pub const ValidationExceptionField = struct {
    /// The input fails to satisfy the constraints specified by an Amazon Web
    /// Services service.
    message: []const u8,

    /// The input fails to satisfy the constraints specified by an Amazon Web
    /// Services service.
    name: []const u8,

    pub const json_field_names = .{
        .message = "message",
        .name = "name",
    };
};
