const FallbackBehavior = @import("fallback_behavior.zig").FallbackBehavior;

/// The configuration for inspecting IP addresses in an HTTP header that you
/// specify, instead of using the IP address that's reported by the web request
/// origin. Commonly, this is the X-Forwarded-For (XFF) header, but you can
/// specify any header name.
///
/// If the specified header isn't present in the request, WAF doesn't apply the
/// rule to the web request at all.
///
/// This configuration is used for GeoMatchStatement, AsnMatchStatement, and
/// RateBasedStatement. For IPSetReferenceStatement, use IPSetForwardedIPConfig
/// instead.
///
/// WAF only evaluates the first IP address found in the specified HTTP header.
pub const ForwardedIPConfig = struct {
    /// The match status to assign to the web request if the request doesn't have a
    /// valid IP address in the specified position.
    ///
    /// If the specified header isn't present in the request, WAF doesn't apply the
    /// rule to the web request at all.
    ///
    /// You can specify the following fallback behaviors:
    ///
    /// * `MATCH` - Treat the web request as matching the rule statement. WAF
    ///   applies the rule action to the request.
    ///
    /// * `NO_MATCH` - Treat the web request as not matching the rule statement.
    fallback_behavior: FallbackBehavior,

    /// The name of the HTTP header to use for the IP address. For example, to use
    /// the X-Forwarded-For (XFF) header, set this to `X-Forwarded-For`.
    ///
    /// If the specified header isn't present in the request, WAF doesn't apply the
    /// rule to the web request at all.
    header_name: []const u8,

    pub const json_field_names = .{
        .fallback_behavior = "FallbackBehavior",
        .header_name = "HeaderName",
    };
};
