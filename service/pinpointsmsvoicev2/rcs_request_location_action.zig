/// A suggested action that requests the recipient's current location.
pub const RcsRequestLocationAction = struct {
    /// The postback data sent to your webhook when the user taps this action.
    /// Maximum 2048 characters.
    postback_data: []const u8,

    /// The display text of the action. Maximum 25 characters.
    text: []const u8,

    pub const json_field_names = .{
        .postback_data = "PostbackData",
        .text = "Text",
    };
};
