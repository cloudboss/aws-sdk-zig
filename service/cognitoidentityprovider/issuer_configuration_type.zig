const IssuerType = @import("issuer_type.zig").IssuerType;

/// Specifies the issuer configuration for a user pool. Contains settings that
/// determine how tokens are issued and validated.
pub const IssuerConfigurationType = struct {
    /// The type of issuer configuration. Determines the token issuing behavior for
    /// the user pool.
    ///
    /// **ORIGINAL**
    ///
    /// The original issuer configuration for user pools. The issuer URL is hosted
    /// in the user
    /// pool’s region and provides OIDC endpoints specific to that region.
    ///
    /// Original issuers have the format of
    /// `https://cognito-idp.[region].amazonaws.com/[userPoolId]`
    ///
    /// **UPDATED**
    ///
    /// Recommended for all user pools, including for multi-Region replication.
    /// Updated issuers host
    /// the same JWKS content in multiple regions, resulting in improved resilience
    /// and efficiency.
    ///
    /// Updated issuers have the format of
    /// `https://issuer-cognito-idp.[region].amazonaws.com/[userPoolId]`, where
    /// region is the
    /// primary Amazon Web Services Region of your user pool.
    type: ?IssuerType = null,

    pub const json_field_names = .{
        .type = "Type",
    };
};
