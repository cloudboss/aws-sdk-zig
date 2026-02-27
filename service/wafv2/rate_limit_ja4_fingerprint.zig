const FallbackBehavior = @import("fallback_behavior.zig").FallbackBehavior;

/// Use the request's JA4 fingerprint derived from the TLS Client Hello of an
/// incoming request as an aggregate key. If you use a single
/// JA4 fingerprint as your custom key, then each value fully defines an
/// aggregation instance.
pub const RateLimitJA4Fingerprint = struct {
    /// The match status to assign to the web request if there is insufficient TSL
    /// Client Hello information to compute the JA4 fingerprint.
    ///
    /// You can specify the following fallback behaviors:
    ///
    /// * `MATCH` - Treat the web request as matching the rule statement. WAF
    ///   applies the rule action to the request.
    ///
    /// * `NO_MATCH` - Treat the web request as not matching the rule statement.
    fallback_behavior: FallbackBehavior,

    pub const json_field_names = .{
        .fallback_behavior = "FallbackBehavior",
    };
};
