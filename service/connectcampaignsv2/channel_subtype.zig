/// The type of campaign channel subtype.
pub const ChannelSubtype = enum {
    telephony,
    sms,
    email,
    whatsapp,

    pub const json_field_names = .{
        .telephony = "TELEPHONY",
        .sms = "SMS",
        .email = "EMAIL",
        .whatsapp = "WHATSAPP",
    };
};
