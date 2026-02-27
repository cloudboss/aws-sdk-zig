pub const DeleteFirewallRuleRequest = struct {
    /// The ID of the domain list that's used in the rule.
    firewall_domain_list_id: ?[]const u8,

    /// The unique identifier of the firewall rule group that you want to delete the
    /// rule from.
    firewall_rule_group_id: []const u8,

    /// The ID that is created for a DNS Firewall Advanced rule.
    firewall_threat_protection_id: ?[]const u8,

    /// The DNS query type that the rule you are deleting evaluates. Allowed values
    /// are;
    ///
    /// * A: Returns an IPv4 address.
    ///
    /// * AAAA: Returns an Ipv6 address.
    ///
    /// * CAA: Restricts CAs that can create SSL/TLS certifications for the domain.
    ///
    /// * CNAME: Returns another domain name.
    ///
    /// * DS: Record that identifies the DNSSEC signing key of a delegated zone.
    ///
    /// * MX: Specifies mail servers.
    ///
    /// * NAPTR: Regular-expression-based rewriting of domain names.
    ///
    /// * NS: Authoritative name servers.
    ///
    /// * PTR: Maps an IP address to a domain name.
    ///
    /// * SOA: Start of authority record for the zone.
    ///
    /// * SPF: Lists the servers authorized to send emails from a domain.
    ///
    /// * SRV: Application specific values that identify servers.
    ///
    /// * TXT: Verifies email senders and application-specific values.
    ///
    /// * A query type you define by using the DNS type ID, for example 28 for AAAA.
    ///   The values must be
    /// defined as TYPENUMBER, where the
    /// NUMBER can be 1-65334, for
    /// example, TYPE28. For more information, see
    /// [List of DNS record
    /// types](https://en.wikipedia.org/wiki/List_of_DNS_record_types).
    qtype: ?[]const u8,

    pub const json_field_names = .{
        .firewall_domain_list_id = "FirewallDomainListId",
        .firewall_rule_group_id = "FirewallRuleGroupId",
        .firewall_threat_protection_id = "FirewallThreatProtectionId",
        .qtype = "Qtype",
    };
};
