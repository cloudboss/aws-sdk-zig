pub const Capability = enum {
    voice,
    sms,

    pub const json_field_names = .{
        .voice = "Voice",
        .sms = "SMS",
    };
};
