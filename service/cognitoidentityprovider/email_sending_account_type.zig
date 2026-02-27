pub const EmailSendingAccountType = enum {
    cognito_default,
    developer,

    pub const json_field_names = .{
        .cognito_default = "COGNITO_DEFAULT",
        .developer = "DEVELOPER",
    };
};
