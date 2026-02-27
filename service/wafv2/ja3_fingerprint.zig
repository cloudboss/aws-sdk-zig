const FallbackBehavior = @import("fallback_behavior.zig").FallbackBehavior;

/// Available for use with Amazon CloudFront distributions and Application Load
/// Balancers. Match against the request's JA3 fingerprint. The JA3 fingerprint
/// is a 32-character hash derived from the TLS Client Hello of an incoming
/// request. This fingerprint serves as a unique identifier for the client's TLS
/// configuration. WAF calculates and logs this fingerprint for each
/// request that has enough TLS Client Hello information for the calculation.
/// Almost
/// all web requests include this information.
///
/// You can use this choice only with a string match `ByteMatchStatement` with
/// the `PositionalConstraint` set to
/// `EXACTLY`.
///
/// You can obtain the JA3 fingerprint for client requests from the web ACL
/// logs.
/// If WAF is able to calculate the fingerprint, it includes it in the logs.
/// For information about the logging fields,
/// see [Log
/// fields](https://docs.aws.amazon.com/waf/latest/developerguide/logging-fields.html) in the *WAF Developer Guide*.
///
/// Provide the JA3 fingerprint string from the logs in your string match
/// statement
/// specification, to match with any future requests that have the same TLS
/// configuration.
pub const JA3Fingerprint = struct {
    /// The match status to assign to the web request if the request doesn't have a
    /// JA3 fingerprint.
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
