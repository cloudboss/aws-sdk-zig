/// The type of campaign communication time config
pub const CommunicationTimeConfigType = enum {
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
