const CloudFrontOriginAccessIdentityConfig = @import("cloud_front_origin_access_identity_config.zig").CloudFrontOriginAccessIdentityConfig;

/// CloudFront origin access identity.
pub const CloudFrontOriginAccessIdentity = struct {
    /// The current configuration information for the identity.
    cloud_front_origin_access_identity_config: ?CloudFrontOriginAccessIdentityConfig = null,

    /// The ID for the origin access identity, for example, `E74FTE3AJFJ256A`.
    id: []const u8,

    /// The Amazon S3 canonical user ID for the origin access identity, used when
    /// giving the origin access identity read permission to an object in Amazon S3.
    s3_canonical_user_id: []const u8,
};
