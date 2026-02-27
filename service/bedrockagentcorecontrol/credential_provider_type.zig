pub const CredentialProviderType = enum {
    gateway_iam_role,
    oauth,
    api_key,

    pub const json_field_names = .{
        .gateway_iam_role = "GATEWAY_IAM_ROLE",
        .oauth = "OAUTH",
        .api_key = "API_KEY",
    };
};
