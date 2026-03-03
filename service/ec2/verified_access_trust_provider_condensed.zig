const DeviceTrustProviderType = @import("device_trust_provider_type.zig").DeviceTrustProviderType;
const TrustProviderType = @import("trust_provider_type.zig").TrustProviderType;
const UserTrustProviderType = @import("user_trust_provider_type.zig").UserTrustProviderType;

/// Condensed information about a trust provider.
pub const VerifiedAccessTrustProviderCondensed = struct {
    /// The description of trust provider.
    description: ?[]const u8 = null,

    /// The type of device-based trust provider.
    device_trust_provider_type: ?DeviceTrustProviderType = null,

    /// The type of trust provider (user- or device-based).
    trust_provider_type: ?TrustProviderType = null,

    /// The type of user-based trust provider.
    user_trust_provider_type: ?UserTrustProviderType = null,

    /// The ID of the trust provider.
    verified_access_trust_provider_id: ?[]const u8 = null,
};
