/// An input event for a end user message in an Amazon Q Business web
/// experience.
pub const TextInputEvent = struct {
    /// A user message in a text message input event.
    user_message: []const u8,

    pub const json_field_names = .{
        .user_message = "userMessage",
    };
};
