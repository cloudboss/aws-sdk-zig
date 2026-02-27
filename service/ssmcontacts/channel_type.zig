pub const ChannelType = enum {
    sms,
    voice,
    email,

    pub const json_field_names = .{
        .sms = "SMS",
        .voice = "VOICE",
        .email = "EMAIL",
    };
};
