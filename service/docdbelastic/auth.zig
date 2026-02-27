pub const Auth = enum {
    plain_text,
    secret_arn,

    pub const json_field_names = .{
        .plain_text = "PLAIN_TEXT",
        .secret_arn = "SECRET_ARN",
    };
};
