/// Details about the state of a resource.
pub const StateDescription = struct {
    /// A code that describes the state of a resource.
    code: ?[]const u8 = null,

    /// A message that describes the state of a resource.
    message: ?[]const u8 = null,

    pub const json_field_names = .{
        .code = "code",
        .message = "message",
    };
};
