const CredentialProviderVendorType = @import("credential_provider_vendor_type.zig").CredentialProviderVendorType;

/// Contains information about an OAuth2 credential provider.
pub const Oauth2CredentialProviderItem = struct {
    /// The timestamp when the OAuth2 credential provider was created.
    created_time: i64,

    /// The Amazon Resource Name (ARN) of the OAuth2 credential provider.
    credential_provider_arn: []const u8,

    /// The vendor of the OAuth2 credential provider.
    credential_provider_vendor: CredentialProviderVendorType,

    /// The timestamp when the OAuth2 credential provider was last updated.
    last_updated_time: i64,

    /// The name of the OAuth2 credential provider.
    name: []const u8,

    pub const json_field_names = .{
        .created_time = "createdTime",
        .credential_provider_arn = "credentialProviderArn",
        .credential_provider_vendor = "credentialProviderVendor",
        .last_updated_time = "lastUpdatedTime",
        .name = "name",
    };
};
