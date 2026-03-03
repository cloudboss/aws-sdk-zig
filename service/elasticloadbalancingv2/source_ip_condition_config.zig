/// Information about a source IP condition.
///
/// You can use this condition to route based on the IP address of the source
/// that connects to
/// the load balancer. If a client is behind a proxy, this is the IP address of
/// the proxy not the
/// IP address of the client.
pub const SourceIpConditionConfig = struct {
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
