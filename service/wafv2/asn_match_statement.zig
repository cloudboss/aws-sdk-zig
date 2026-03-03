const ForwardedIPConfig = @import("forwarded_ip_config.zig").ForwardedIPConfig;

/// A rule statement that inspects web traffic based on the Autonomous System
/// Number (ASN) associated with the request's IP address.
///
/// For additional details, see [ASN match rule
/// statement](https://docs.aws.amazon.com/waf/latest/developerguide/waf-rule-statement-type-asn-match.html) in the [WAF Developer Guide](https://docs.aws.amazon.com/waf/latest/developerguide/waf-chapter.html).
pub const AsnMatchStatement = struct {
    /// Contains one or more Autonomous System Numbers (ASNs).
    /// ASNs are unique identifiers assigned to large internet networks managed by
    /// organizations such as
    /// internet service providers, enterprises, universities, or government
    /// agencies.
    asn_list: []const i64,

    /// The configuration for inspecting IP addresses to match against an ASN in an
    /// HTTP header that you specify,
    /// instead of using the IP address that's reported by the web request origin.
    /// Commonly, this is the X-Forwarded-For (XFF) header,
    /// but you can specify any header name.
    forwarded_ip_config: ?ForwardedIPConfig = null,

    pub const json_field_names = .{
        .asn_list = "AsnList",
        .forwarded_ip_config = "ForwardedIPConfig",
    };
};
