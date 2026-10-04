/// Contains detailed information about an ACME external account binding.
pub const AcmeExternalAccountBinding = struct {
    /// The Amazon Resource Name (ARN) of the ACME endpoint.
    acme_endpoint_arn: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the ACME external account binding.
    acme_external_account_binding_arn: ?[]const u8 = null,

    /// The time at which the external account binding was created.
    created_at: ?i64 = null,

    /// The time at which the external account binding expires.
    expires_at: ?i64 = null,

    /// The time at which the external account binding was last used.
    last_used_at: ?i64 = null,

    /// The time at which the external account binding was revoked.
    revoked_at: ?i64 = null,

    /// The Amazon Resource Name (ARN) of the IAM role associated with the external
    /// account binding.
    role_arn: ?[]const u8 = null,

    /// The time at which the external account binding was last updated.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .acme_endpoint_arn = "AcmeEndpointArn",
        .acme_external_account_binding_arn = "AcmeExternalAccountBindingArn",
        .created_at = "CreatedAt",
        .expires_at = "ExpiresAt",
        .last_used_at = "LastUsedAt",
        .revoked_at = "RevokedAt",
        .role_arn = "RoleArn",
        .updated_at = "UpdatedAt",
    };
};
