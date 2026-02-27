pub const ChannelType = enum {
    facebook,
    slack,
    twilio_sms,
    kik,

    pub const json_field_names = .{
        .facebook = "FACEBOOK",
        .slack = "SLACK",
        .twilio_sms = "TWILIO_SMS",
        .kik = "KIK",
    };
};
