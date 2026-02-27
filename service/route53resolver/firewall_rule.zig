const Action = @import("action.zig").Action;
const BlockOverrideDnsType = @import("block_override_dns_type.zig").BlockOverrideDnsType;
const BlockResponse = @import("block_response.zig").BlockResponse;
const ConfidenceThreshold = @import("confidence_threshold.zig").ConfidenceThreshold;
const DnsThreatProtection = @import("dns_threat_protection.zig").DnsThreatProtection;
const FirewallDomainRedirectionAction = @import("firewall_domain_redirection_action.zig").FirewallDomainRedirectionAction;

/// A single firewall rule in a rule group.
pub const FirewallRule = struct {
    /// The action that DNS Firewall should take on a DNS query when it matches one
    /// of the domains in the rule's domain list, or a threat in a DNS Firewall
    /// Advanced rule:
    ///
    /// * `ALLOW` - Permit the request to go through. Not available for DNS Firewall
    ///   Advanced rules.
    ///
    /// * `ALERT` - Permit the request to go through but send an alert to the logs.
    ///
    /// * `BLOCK` - Disallow the request. If this is specified, additional handling
    ///   details are provided in the rule's `BlockResponse` setting.
    action: ?Action,

    /// The DNS record's type. This determines the format of the record value that
    /// you provided in `BlockOverrideDomain`. Used for the rule action `BLOCK` with
    /// a `BlockResponse` setting of `OVERRIDE`.
    block_override_dns_type: ?BlockOverrideDnsType,

    /// The custom DNS record to send back in response to the query. Used for the
    /// rule action `BLOCK` with a `BlockResponse` setting of `OVERRIDE`.
    block_override_domain: ?[]const u8,

    /// The recommended amount of time, in seconds, for the DNS resolver or web
    /// browser to cache the provided override record. Used for the rule action
    /// `BLOCK` with a `BlockResponse` setting of `OVERRIDE`.
    block_override_ttl: ?i32,

    /// The way that you want DNS Firewall to block the request. Used for the rule
    /// action setting `BLOCK`.
    ///
    /// * `NODATA` - Respond indicating that the query was successful, but no
    ///   response is available for it.
    ///
    /// * `NXDOMAIN` - Respond indicating that the domain name that's in the query
    ///   doesn't exist.
    ///
    /// * `OVERRIDE` - Provide a custom override in the response. This option
    ///   requires custom handling details in the rule's `BlockOverride*` settings.
    block_response: ?BlockResponse,

    /// The confidence threshold for DNS Firewall Advanced. You must provide this
    /// value when you create a DNS Firewall Advanced rule. The confidence
    /// level values mean:
    ///
    /// * `LOW`: Provides the highest detection rate for threats, but also increases
    ///   false positives.
    ///
    /// * `MEDIUM`: Provides a balance between detecting threats and false
    ///   positives.
    ///
    /// * `HIGH`: Detects only the most well corroborated threats with a low rate of
    ///   false positives.
    confidence_threshold: ?ConfidenceThreshold,

    /// The date and time that the rule was created, in Unix time format and
    /// Coordinated Universal Time (UTC).
    creation_time: ?[]const u8,

    /// A unique string defined by you to identify the request. This allows you to
    /// retry failed requests
    /// without the risk of executing the operation twice. This can be any unique
    /// string, for example, a timestamp.
    creator_request_id: ?[]const u8,

    /// The type of the DNS Firewall Advanced rule. Valid values are:
    ///
    /// * `DGA`: Domain generation algorithms detection. DGAs are used by attackers
    ///   to generate a large number of domains
    /// to to launch malware attacks.
    ///
    /// * `DNS_TUNNELING`: DNS tunneling detection. DNS tunneling is used by
    ///   attackers to exfiltrate data from the client by using the DNS tunnel
    ///   without
    /// making a network connection to the client.
    dns_threat_protection: ?DnsThreatProtection,

    /// The ID of the domain list that's used in the rule.
    firewall_domain_list_id: ?[]const u8,

    /// How you want the the rule to evaluate DNS redirection in the DNS redirection
    /// chain, such as CNAME or DNAME.
    ///
    /// `INSPECT_REDIRECTION_DOMAIN`: (Default) inspects all domains in the
    /// redirection chain. The individual domains in the redirection chain must be
    /// added to the domain list.
    ///
    /// `TRUST_REDIRECTION_DOMAIN`: Inspects only the first domain in the
    /// redirection chain. You don't need to add the subsequent domains in the
    /// domain in the redirection list to
    /// the domain list.
    firewall_domain_redirection_action: ?FirewallDomainRedirectionAction,

    /// The unique identifier of the Firewall rule group of the rule.
    firewall_rule_group_id: ?[]const u8,

    /// ID of the DNS Firewall Advanced rule.
    firewall_threat_protection_id: ?[]const u8,

    /// The date and time that the rule was last modified, in Unix time format and
    /// Coordinated Universal Time (UTC).
    modification_time: ?[]const u8,

    /// The name of the rule.
    name: ?[]const u8,

    /// The priority of the rule in the rule group. This value must be unique within
    /// the rule group. DNS Firewall processes the rules in a rule group by order of
    /// priority, starting from the lowest setting.
    priority: ?i32,

    /// The DNS query type you want the rule to evaluate. Allowed values are;
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
        .action = "Action",
        .block_override_dns_type = "BlockOverrideDnsType",
        .block_override_domain = "BlockOverrideDomain",
        .block_override_ttl = "BlockOverrideTtl",
        .block_response = "BlockResponse",
        .confidence_threshold = "ConfidenceThreshold",
        .creation_time = "CreationTime",
        .creator_request_id = "CreatorRequestId",
        .dns_threat_protection = "DnsThreatProtection",
        .firewall_domain_list_id = "FirewallDomainListId",
        .firewall_domain_redirection_action = "FirewallDomainRedirectionAction",
        .firewall_rule_group_id = "FirewallRuleGroupId",
        .firewall_threat_protection_id = "FirewallThreatProtectionId",
        .modification_time = "ModificationTime",
        .name = "Name",
        .priority = "Priority",
        .qtype = "Qtype",
    };
};
