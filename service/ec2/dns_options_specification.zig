const DnsRecordIpType = @import("dns_record_ip_type.zig").DnsRecordIpType;

/// Describes the DNS options for an endpoint.
pub const DnsOptionsSpecification = struct {
    /// The DNS records created for the endpoint.
    dns_record_ip_type: ?DnsRecordIpType,

    /// Indicates whether to enable private DNS only for inbound endpoints. This
    /// option is
    /// available only for services that support both gateway and interface
    /// endpoints. It routes
    /// traffic that originates from the VPC to the gateway endpoint and traffic
    /// that originates
    /// from on-premises to the interface endpoint.
    private_dns_only_for_inbound_resolver_endpoint: ?bool,

    /// The preference for which private domains have a private hosted zone created
    /// for and associated with the specified VPC. Only supported when private DNS
    /// is enabled and when the VPC endpoint type is ServiceNetwork or Resource.
    ///
    /// * `ALL_DOMAINS` - VPC Lattice provisions private hosted zones for all custom
    ///   domain names.
    ///
    /// * `VERIFIED_DOMAINS_ONLY` - VPC Lattice provisions a private hosted zone
    ///   only if custom domain name has been verified by the provider.
    ///
    /// * `VERIFIED_DOMAINS_AND_SPECIFIED_DOMAINS` - VPC Lattice provisions private
    ///   hosted zones for all verified custom domain names and other domain names
    ///   that the resource consumer specifies. The resource consumer specifies the
    ///   domain names in the PrivateDnsSpecifiedDomains parameter.
    ///
    /// * `SPECIFIED_DOMAINS_ONLY` - VPC Lattice provisions a private hosted zone
    ///   for domain names specified by the resource consumer. The resource consumer
    ///   specifies the domain names in the PrivateDnsSpecifiedDomains parameter.
    private_dns_preference: ?[]const u8,

    /// Indicates which of the private domains to create private hosted zones for
    /// and associate with the specified VPC. Only supported when private DNS is
    /// enabled and the private DNS preference is
    /// verified-domains-and-specified-domains or specified-domains-only.
    private_dns_specified_domains: ?[]const []const u8,
};
