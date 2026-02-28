/// Specifies the request's HTTP method as an aggregate key for a rate-based
/// rule. Each distinct HTTP method contributes to the aggregation instance. If
/// you use just the HTTP method
/// as your custom key, then each method fully defines an aggregation instance.
///
/// JSON specification: `"RateLimitHTTPMethod": {}`
pub const RateLimitHTTPMethod = struct {
};
