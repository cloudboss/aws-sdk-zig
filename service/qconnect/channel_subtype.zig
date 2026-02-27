pub const ChannelSubtype = enum {
    email,
    sms,
    whatsapp,
    push,

    pub const json_field_names = .{
        .email = "EMAIL",
        .sms = "SMS",
        .whatsapp = "WHATSAPP",
        .push = "PUSH",
    };
};
