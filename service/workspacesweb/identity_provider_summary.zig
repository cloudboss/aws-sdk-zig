const IdentityProviderType = @import("identity_provider_type.zig").IdentityProviderType;

/// The summary of the identity provider.
pub const IdentityProviderSummary = struct {
    /// The ARN of the identity provider.
    identity_provider_arn: []const u8,

    /// The identity provider name.
    identity_provider_name: ?[]const u8,

    /// The identity provider type.
    identity_provider_type: ?IdentityProviderType,

    pub const json_field_names = .{
        .identity_provider_arn = "identityProviderArn",
        .identity_provider_name = "identityProviderName",
        .identity_provider_type = "identityProviderType",
    };
};
