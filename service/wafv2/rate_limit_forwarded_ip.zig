/// Specifies the first IP address in an HTTP header as an aggregate key for a
/// rate-based rule. Each distinct forwarded IP address contributes to the
/// aggregation instance.
///
/// This setting is used only in the `RateBasedStatementCustomKey` specification
/// of a rate-based rule statement.
/// When you specify an IP or forwarded IP in the custom key settings, you must
/// also specify at least one other key to use.
/// You can aggregate on only the forwarded IP address by specifying
/// `FORWARDED_IP` in your rate-based statement's `AggregateKeyType`.
///
/// This data type supports using the forwarded IP address in the web request
/// aggregation for a rate-based rule, in `RateBasedStatementCustomKey`. The
/// JSON specification for using the forwarded IP address doesn't explicitly use
/// this data type.
///
/// JSON specification: `"ForwardedIP": {}`
///
/// When you use this specification, you must also configure the forwarded IP
/// address in the rate-based statement's `ForwardedIPConfig`.
pub const RateLimitForwardedIP = struct {
};
