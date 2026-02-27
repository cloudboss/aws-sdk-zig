pub const TemplateType = enum {
    email,
    sms,
    voice,
    push,
    inapp,

    pub const json_field_names = .{
        .email = "EMAIL",
        .sms = "SMS",
        .voice = "VOICE",
        .push = "PUSH",
        .inapp = "INAPP",
    };
};
