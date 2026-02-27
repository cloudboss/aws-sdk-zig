pub const NumberCapability = enum {
    sms,
    voice,
    mms,

    pub const json_field_names = .{
        .sms = "SMS",
        .voice = "VOICE",
        .mms = "MMS",
    };
};
