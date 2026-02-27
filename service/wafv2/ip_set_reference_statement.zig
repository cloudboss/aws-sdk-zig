const IPSetForwardedIPConfig = @import("ip_set_forwarded_ip_config.zig").IPSetForwardedIPConfig;

/// A rule statement used to detect web requests coming from particular IP
/// addresses or address ranges. To use this, create an IPSet that specifies the
/// addresses you want to detect, then use the ARN of that set in this
/// statement. To create an IP set, see CreateIPSet.
///
/// Each IP set rule statement references an IP set. You create and maintain the
/// set independent of your rules. This allows you to use the single set in
/// multiple rules. When you update the referenced set, WAF automatically
/// updates all rules that reference it.
pub const IPSetReferenceStatement = struct {
    /// The Amazon Resource Name (ARN) of the IPSet that this statement
    /// references.
    arn: []const u8,

    /// The configuration for inspecting IP addresses in an HTTP header that you
    /// specify, instead of using the IP address that's reported by the web request
    /// origin. Commonly, this is the X-Forwarded-For (XFF) header, but you can
    /// specify any header name.
    ///
    /// If the specified header isn't present in the request, WAF doesn't apply the
    /// rule to the web request at all.
    ip_set_forwarded_ip_config: ?IPSetForwardedIPConfig,

    pub const json_field_names = .{
        .arn = "ARN",
        .ip_set_forwarded_ip_config = "IPSetForwardedIPConfig",
    };
};
