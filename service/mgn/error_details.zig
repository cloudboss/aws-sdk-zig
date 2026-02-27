/// Error details.
pub const ErrorDetails = struct {
    /// Error details code.
    code: ?[]const u8,

    /// Error details message.
    message: ?[]const u8,

    /// Error details resourceId.
    resource_id: ?[]const u8,

    /// Error details resourceType.
    resource_type: ?[]const u8,

    pub const json_field_names = .{
        .code = "code",
        .message = "message",
        .resource_id = "resourceId",
        .resource_type = "resourceType",
    };
};
