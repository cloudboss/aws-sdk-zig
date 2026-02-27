/// A message associated with a router output.
pub const RouterOutputMessage = struct {
    /// The code associated with the router output message.
    code: []const u8,

    /// The message text associated with the router output message.
    message: []const u8,

    pub const json_field_names = .{
        .code = "Code",
        .message = "Message",
    };
};
