const IdentityProviderTypeType = @import("identity_provider_type_type.zig").IdentityProviderTypeType;

/// The details of a user pool identity provider (IdP), including name and type.
pub const ProviderDescription = struct {
    /// The date and time when the item was created. Amazon Cognito returns this
    /// timestamp in UNIX epoch time format. Your SDK might render the output in a
    /// human-readable format like ISO 8601 or a Java `Date` object.
    creation_date: ?i64,

    /// The date and time when the item was modified. Amazon Cognito returns this
    /// timestamp in UNIX epoch time format. Your SDK might render the output in a
    /// human-readable format like ISO 8601 or a Java `Date` object.
    last_modified_date: ?i64,

    /// The name of the IdP, for example `MySAMLProvider`.
    provider_name: ?[]const u8,

    /// The type of the provider, for example `SAML`. Amazon Cognito supports SAML
    /// 2.0,
    /// OIDC, and social IdPs. User pools list supported social IdPs by name in this
    /// response
    /// parameter: Facebook, Google, Login with Amazon, and Sign in with Apple.
    provider_type: ?IdentityProviderTypeType,

    pub const json_field_names = .{
        .creation_date = "CreationDate",
        .last_modified_date = "LastModifiedDate",
        .provider_name = "ProviderName",
        .provider_type = "ProviderType",
    };
};
