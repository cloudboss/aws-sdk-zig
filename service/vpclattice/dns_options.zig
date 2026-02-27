const PrivateDnsPreference = @import("private_dns_preference.zig").PrivateDnsPreference;

/// The DNS configuration options.
pub const DnsOptions = struct {
    /// The preference for which private domains have a private hosted zone created
    /// for and associated with the specified VPC. Only supported when private DNS
    /// is enabled and when the VPC endpoint type is ServiceNetwork or Resource.
    ///
    /// * `ALL_DOMAINS` - VPC Lattice provisions private hosted zones for all custom
    ///   domain names.
    /// * `VERIFIED_DOMAINS_ONLY` - VPC Lattice provisions a private hosted zone
    ///   only if custom domain name has been verified by the provider.
    /// * `VERIFIED_DOMAINS_AND_SPECIFIED_DOMAINS` - VPC Lattice provisions private
    ///   hosted zones for all verified custom domain names and other domain names
    ///   that the resource consumer specifies. The resource consumer specifies the
    ///   domain names in the privateDnsSpecifiedDomains parameter.
    /// * `SPECIFIED_DOMAINS_ONLY` - VPC Lattice provisions a private hosted zone
    ///   for domain names specified by the resource consumer. The resource consumer
    ///   specifies the domain names in the privateDnsSpecifiedDomains parameter.
    private_dns_preference: ?PrivateDnsPreference,

    /// Indicates which of the private domains to create private hosted zones for
    /// and associate with the specified VPC. Only supported when private DNS is
    /// enabled and the private DNS preference is
    /// `VERIFIED_DOMAINS_AND_SPECIFIED_DOMAINS` or `SPECIFIED_DOMAINS_ONLY`.
    private_dns_specified_domains: ?[]const []const u8,

    pub const json_field_names = .{
        .private_dns_preference = "privateDnsPreference",
        .private_dns_specified_domains = "privateDnsSpecifiedDomains",
    };
};
