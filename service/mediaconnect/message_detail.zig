/// The details of an error message.
pub const MessageDetail = struct {
    /// The error code.
    code: []const u8,

    /// The specific error message that MediaConnect returns to help you understand
    /// the reason that the request did not succeed.
    message: []const u8,

    /// The name of the resource.
    resource_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .code = "Code",
        .message = "Message",
        .resource_name = "ResourceName",
    };
};
