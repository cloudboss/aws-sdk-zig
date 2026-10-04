const SourceIpAddressTypeEnum = @import("source_ip_address_type_enum.zig").SourceIpAddressTypeEnum;

/// Information about a source IP condition.
///
/// You can use this condition to route based on the IP address of the source
/// that connects to
/// the load balancer. If a client is behind a proxy, this is the IP address of
/// the proxy not the
/// IP address of the client.
///
/// For Application Load Balancers, use `Values` to specify CIDR ranges. For
/// Network Load Balancers, use `IpAddressType` to match on the IP address type
/// of
/// the source traffic.
pub const SourceIpConditionConfig = struct {
    /// The IP address type for Network Load Balancers.
    ///
    /// The valid values are:
    ///
    /// * `ipv4` – IPv4 addresses only.
    ///
    /// * `ipv6` – IPv6 addresses only.
    ip_address_type: ?SourceIpAddressTypeEnum = null,

    /// The source IP addresses, in CIDR format. You can use both IPv4 and IPv6
    /// addresses.
    /// Wildcards are not supported.
    ///
    /// If you specify multiple addresses, the condition is satisfied if the source
    /// IP address of
    /// the request matches one of the CIDR blocks. This condition is not satisfied
    /// by the addresses
    /// in the X-Forwarded-For header. To search for addresses in the
    /// X-Forwarded-For header, use
    /// an [HTTP header
    /// condition](https://docs.aws.amazon.com/elasticloadbalancing/latest/application/load-balancer-listeners.html#http-header-conditions).
    ///
    /// The total number of values must be less than, or equal to five.
    values: ?[]const []const u8 = null,
};
