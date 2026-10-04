/// A suggested action that initiates a phone call to a specified number when
/// tapped by the recipient.
pub const RcsDialPhoneAction = struct {
    /// The phone number to dial in E.164 format.
    phone_number: []const u8,

    /// The postback data sent to your webhook when the user taps this action.
    /// Maximum 2048 characters.
    postback_data: []const u8,

    /// The display text of the action. Maximum 25 characters.
    text: []const u8,

    pub const json_field_names = .{
        .phone_number = "PhoneNumber",
        .postback_data = "PostbackData",
        .text = "Text",
    };
};
