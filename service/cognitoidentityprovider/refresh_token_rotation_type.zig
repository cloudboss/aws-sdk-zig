const FeatureType = @import("feature_type.zig").FeatureType;

/// The configuration of your app client for refresh token rotation. When
/// enabled, your
/// app client issues new ID, access, and refresh tokens when users renew their
/// sessions
/// with refresh tokens. When disabled, token refresh issues only ID and access
/// tokens.
pub const RefreshTokenRotationType = struct {
    /// The state of refresh token rotation for the current app client.
    feature: FeatureType,

    /// When you request a token refresh with `GetTokensFromRefreshToken`, the
    /// original refresh token that you're rotating out can remain valid for a
    /// period of time of
    /// up to 60 seconds. This allows for client-side retries. When
    /// `RetryGracePeriodSeconds` is `0`, the grace period is disabled
    /// and a successful request immediately invalidates the submitted refresh
    /// token.
    retry_grace_period_seconds: ?i32,

    pub const json_field_names = .{
        .feature = "Feature",
        .retry_grace_period_seconds = "RetryGracePeriodSeconds",
    };
};
