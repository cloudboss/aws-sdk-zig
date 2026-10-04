/// A suggested reply action that sends predefined text and postback data when
/// tapped by the recipient.
pub const RcsReplyAction = struct {
    /// The postback data sent to your webhook when the user taps this reply.
    /// Maximum 2048 characters.
    postback_data: []const u8,

    /// The display text of the suggested reply. Maximum 25 characters.
    text: []const u8,

    pub const json_field_names = .{
        .postback_data = "PostbackData",
        .text = "Text",
    };
};
