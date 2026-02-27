pub const ResourceType = enum {
    device_certificate,
    ca_certificate,
    iot_policy,
    cognito_identity_pool,
    client_id,
    account_settings,
    role_alias,
    iam_role,
    issuer_certificate,

    pub const json_field_names = .{
        .device_certificate = "DEVICE_CERTIFICATE",
        .ca_certificate = "CA_CERTIFICATE",
        .iot_policy = "IOT_POLICY",
        .cognito_identity_pool = "COGNITO_IDENTITY_POOL",
        .client_id = "CLIENT_ID",
        .account_settings = "ACCOUNT_SETTINGS",
        .role_alias = "ROLE_ALIAS",
        .iam_role = "IAM_ROLE",
        .issuer_certificate = "ISSUER_CERTIFICATE",
    };
};
