/// Specifies the IP address in the web request as an aggregate key for a
/// rate-based rule. Each distinct IP address contributes to the aggregation
/// instance.
///
/// This setting is used only in the `RateBasedStatementCustomKey` specification
/// of a rate-based rule statement.
/// To use this in the custom key settings, you must specify at least one other
/// key to use, along with the IP address.
/// To aggregate on only the IP address, in your rate-based statement's
/// `AggregateKeyType`, specify `IP`.
///
/// JSON specification: `"RateLimitIP": {}`
pub const RateLimitIP = struct {
};
