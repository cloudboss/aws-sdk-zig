/// The phone number and proxy phone number for a participant in an Amazon Chime
/// SDK Voice Connector proxy session.
pub const Participant = struct {
    /// The participant's phone number.
    phone_number: ?[]const u8 = null,

    /// The participant's proxy phone number.
    proxy_phone_number: ?[]const u8 = null,

    pub const json_field_names = .{
        .phone_number = "PhoneNumber",
        .proxy_phone_number = "ProxyPhoneNumber",
    };
};
