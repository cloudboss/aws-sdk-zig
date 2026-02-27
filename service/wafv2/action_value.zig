pub const ActionValue = enum {
    allow,
    block,
    count,
    captcha,
    challenge,
    excluded_as_count,

    pub const json_field_names = .{
        .allow = "ALLOW",
        .block = "BLOCK",
        .count = "COUNT",
        .captcha = "CAPTCHA",
        .challenge = "CHALLENGE",
        .excluded_as_count = "EXCLUDED_AS_COUNT",
    };
};
