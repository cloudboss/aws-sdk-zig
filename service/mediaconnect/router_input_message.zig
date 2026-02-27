/// A message associated with a router input, including a code and a message.
pub const RouterInputMessage = struct {
    /// The code associated with the router input message.
    code: []const u8,

    /// The message text associated with the router input message.
    message: []const u8,

    pub const json_field_names = .{
        .code = "Code",
        .message = "Message",
    };
};
