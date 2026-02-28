/// Specifies an Autonomous System Number (ASN) derived from the request's
/// originating or forwarded IP address as an aggregate key for a rate-based
/// rule.
/// Each distinct ASN contributes to the aggregation instance.
/// If you use a single ASN as your custom key, then each ASN fully defines an
/// aggregation instance.
pub const RateLimitAsn = struct {
};
