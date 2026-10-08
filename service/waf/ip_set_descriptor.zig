const IPSetDescriptorType = @import("ip_set_descriptor_type.zig").IPSetDescriptorType;

/// This is **AWS WAF Classic** documentation. For
/// more information, see [AWS
/// WAF
/// Classic](https://docs.aws.amazon.com/waf/latest/developerguide/classic-waf-chapter.html) in the developer guide.
///
/// **For the latest version of AWS
/// WAF**, use the AWS WAFV2 API and see the [AWS WAF Developer
/// Guide](https://docs.aws.amazon.com/waf/latest/developerguide/waf-chapter.html). With the latest version, AWS WAF has a single set of endpoints for regional and global use.
///
/// Specifies the IP address type (`IPV4` or `IPV6`) and the IP address range
/// (in CIDR format) that web requests originate from.
pub const IPSetDescriptor = struct {
    /// Specify `IPV4` or `IPV6`.
    type: IPSetDescriptorType,

    /// Specify an IPv4 address by using CIDR notation. For example:
    ///
    /// * To configure AWS WAF to allow, block, or count requests that originated
    ///   from the IP address 192.0.2.44, specify `192.0.2.44/32`.
    ///
    /// * To configure AWS WAF to allow, block, or count requests that originated
    ///   from IP addresses from 192.0.2.0 to 192.0.2.255, specify
    /// `192.0.2.0/24`.
    ///
    /// For more information about CIDR notation, see the Wikipedia entry
    /// [Classless Inter-Domain
    /// Routing](https://en.wikipedia.org/wiki/Classless_Inter-Domain_Routing).
    ///
    /// Specify an IPv6 address by using CIDR notation. For example:
    ///
    /// * To configure AWS WAF to allow, block, or count requests that originated
    ///   from the IP address 1111:0000:0000:0000:0000:0000:0000:0111, specify
    ///   `1111:0000:0000:0000:0000:0000:0000:0111/128`.
    ///
    /// * To configure AWS WAF to allow, block, or count requests that originated
    ///   from IP addresses 1111:0000:0000:0000:0000:0000:0000:0000 to
    ///   1111:0000:0000:0000:ffff:ffff:ffff:ffff, specify
    ///   `1111:0000:0000:0000:0000:0000:0000:0000/64`.
    value: []const u8,

    pub const json_field_names = .{
        .type = "Type",
        .value = "Value",
    };
};
