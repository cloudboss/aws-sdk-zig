const DeviceOptions = @import("device_options.zig").DeviceOptions;
const DeviceTrustProviderType = @import("device_trust_provider_type.zig").DeviceTrustProviderType;
const NativeApplicationOidcOptions = @import("native_application_oidc_options.zig").NativeApplicationOidcOptions;
const OidcOptions = @import("oidc_options.zig").OidcOptions;
const VerifiedAccessSseSpecificationResponse = @import("verified_access_sse_specification_response.zig").VerifiedAccessSseSpecificationResponse;
const Tag = @import("tag.zig").Tag;
const TrustProviderType = @import("trust_provider_type.zig").TrustProviderType;
const UserTrustProviderType = @import("user_trust_provider_type.zig").UserTrustProviderType;

/// Describes a Verified Access trust provider.
pub const VerifiedAccessTrustProvider = struct {
    /// The creation time.
    creation_time: ?[]const u8 = null,

    /// A description for the Amazon Web Services Verified Access trust provider.
    description: ?[]const u8 = null,

    /// The options for device-identity trust provider.
    device_options: ?DeviceOptions = null,

    /// The type of device-based trust provider.
    device_trust_provider_type: ?DeviceTrustProviderType = null,

    /// The last updated time.
    last_updated_time: ?[]const u8 = null,

    /// The OpenID Connect (OIDC) options.
    native_application_oidc_options: ?NativeApplicationOidcOptions = null,

    /// The options for an OpenID Connect-compatible user-identity trust provider.
    oidc_options: ?OidcOptions = null,

    /// The identifier to be used when working with policy rules.
    policy_reference_name: ?[]const u8 = null,

    /// The options in use for server side encryption.
    sse_specification: ?VerifiedAccessSseSpecificationResponse = null,

    /// The tags.
    tags: ?[]const Tag = null,

    /// The type of Verified Access trust provider.
    trust_provider_type: ?TrustProviderType = null,

    /// The type of user-based trust provider.
    user_trust_provider_type: ?UserTrustProviderType = null,

    /// The ID of the Amazon Web Services Verified Access trust provider.
    verified_access_trust_provider_id: ?[]const u8 = null,
};
