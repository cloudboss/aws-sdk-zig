const VerifiedAccessInstanceCustomSubDomain = @import("verified_access_instance_custom_sub_domain.zig").VerifiedAccessInstanceCustomSubDomain;
const Tag = @import("tag.zig").Tag;
const VerifiedAccessTrustProviderCondensed = @import("verified_access_trust_provider_condensed.zig").VerifiedAccessTrustProviderCondensed;

/// Describes a Verified Access instance.
pub const VerifiedAccessInstance = struct {
    /// The custom subdomain.
    cidr_endpoints_custom_sub_domain: ?VerifiedAccessInstanceCustomSubDomain = null,

    /// The creation time.
    creation_time: ?[]const u8 = null,

    /// A description for the Amazon Web Services Verified Access instance.
    description: ?[]const u8 = null,

    /// Indicates whether support for Federal Information Processing Standards
    /// (FIPS) is enabled on the instance.
    fips_enabled: ?bool = null,

    /// The last updated time.
    last_updated_time: ?[]const u8 = null,

    /// The tags.
    tags: ?[]const Tag = null,

    /// The ID of the Amazon Web Services Verified Access instance.
    verified_access_instance_id: ?[]const u8 = null,

    /// The IDs of the Amazon Web Services Verified Access trust providers.
    verified_access_trust_providers: ?[]const VerifiedAccessTrustProviderCondensed = null,
};
