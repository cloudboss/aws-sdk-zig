const IPSetDescriptor = @import("ip_set_descriptor.zig").IPSetDescriptor;

/// This is **AWS WAF Classic** documentation. For
/// more information, see [AWS
/// WAF
/// Classic](https://docs.aws.amazon.com/waf/latest/developerguide/classic-waf-chapter.html) in the developer guide.
///
/// **For the latest version of AWS
/// WAF**, use the AWS WAFV2 API and see the [AWS WAF Developer
/// Guide](https://docs.aws.amazon.com/waf/latest/developerguide/waf-chapter.html). With the latest version, AWS WAF has a single set of endpoints for regional and global use.
///
/// Contains one or more IP addresses or blocks of IP addresses specified in
/// Classless Inter-Domain Routing (CIDR) notation. AWS WAF supports IPv4
/// address ranges: /8 and any range between /16 through /32. AWS WAF supports
/// IPv6 address ranges: /24, /32, /48, /56, /64, and /128.
///
/// To specify an individual IP address, you specify the four-part IP address
/// followed by a
/// `/32`, for example, 192.0.2.0/32. To block a range of IP addresses, you can
/// specify /8 or any range between /16 through /32 (for IPv4) or /24, /32, /48,
/// /56, /64, or
/// /128 (for IPv6). For more information about CIDR notation, see the Wikipedia
/// entry [Classless
/// Inter-Domain
/// Routing](https://en.wikipedia.org/wiki/Classless_Inter-Domain_Routing).
pub const IPSet = struct {
    /// The IP address type (`IPV4` or `IPV6`) and the IP address range (in CIDR
    /// notation) that web requests originate from.
    /// If the `WebACL` is associated with a CloudFront distribution and the viewer
    /// did not use an HTTP proxy or a load balancer to send the request, this is
    /// the value of the c-ip field in the CloudFront access logs.
    ip_set_descriptors: []const IPSetDescriptor,

    /// The `IPSetId` for an `IPSet`. You use `IPSetId` to get information about an
    /// `IPSet` (see GetIPSet), update an `IPSet` (see UpdateIPSet),
    /// insert an `IPSet` into a `Rule` or delete one from a `Rule` (see
    /// UpdateRule), and
    /// delete an `IPSet` from AWS WAF (see DeleteIPSet).
    ///
    /// `IPSetId` is returned by CreateIPSet and by ListIPSets.
    ip_set_id: []const u8,

    /// A friendly name or description of the IPSet. You can't change the name of an
    /// `IPSet` after you create it.
    name: ?[]const u8 = null,

    pub const json_field_names = .{
        .ip_set_descriptors = "IPSetDescriptors",
        .ip_set_id = "IPSetId",
        .name = "Name",
    };
};
