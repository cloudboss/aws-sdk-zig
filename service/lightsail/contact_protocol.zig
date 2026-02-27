pub const ContactProtocol = enum {
    email,
    sms,

    pub const json_field_names = .{
        .email = "Email",
        .sms = "SMS",
    };
};
