pub const SourceControlAuthStrategy = enum {
    personal_access_token,
    aws_secrets_manager,

    pub const json_field_names = .{
        .personal_access_token = "PERSONAL_ACCESS_TOKEN",
        .aws_secrets_manager = "AWS_SECRETS_MANAGER",
    };
};
