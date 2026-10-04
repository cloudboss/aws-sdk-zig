const Action = @import("action.zig").Action;
const BlockOverrideDnsType = @import("block_override_dns_type.zig").BlockOverrideDnsType;
const BlockResponse = @import("block_response.zig").BlockResponse;
const ConfidenceThreshold = @import("confidence_threshold.zig").ConfidenceThreshold;
const DnsThreatProtection = @import("dns_threat_protection.zig").DnsThreatProtection;
const FirewallDomainRedirectionAction = @import("firewall_domain_redirection_action.zig").FirewallDomainRedirectionAction;
const FirewallRuleType = @import("firewall_rule_type.zig").FirewallRuleType;

/// The details for creating a single firewall rule in a batch operation.
pub const CreateFirewallRuleEntry = struct {
    /// The action that DNS Firewall should take on a DNS query when it matches one
    /// of the domains in the rule's domain list, or a threat in a DNS Firewall
    /// Advanced rule:
    ///
    /// * `ALLOW` - Permit the request to go through. Not available for DNS Firewall
    ///   Advanced rules.
    ///
    /// * `ALERT` - Permit the request and send metrics and logs to CloudWatch.
    ///
    /// * `BLOCK` - Disallow the request. This option requires additional details in
    ///   the rule's `BlockResponse`.
    action: Action,

    /// The DNS record's type. This determines the format of the record value that
    /// you provided in `BlockOverrideDomain`. Used for the rule action `BLOCK` with
    /// a `BlockResponse` setting of `OVERRIDE`.
    block_override_dns_type: ?BlockOverrideDnsType = null,

    /// The custom DNS record to send back in response to the query. Used for the
    /// rule action `BLOCK` with a `BlockResponse` setting of `OVERRIDE`.
    block_override_domain: ?[]const u8 = null,

    /// The recommended amount of time, in seconds, for the DNS resolver or web
    /// browser to cache the provided override record. Used for the rule action
    /// `BLOCK` with a `BlockResponse` setting of `OVERRIDE`.
    ///
    /// This setting is required if the `BlockResponse` setting is `OVERRIDE`.
    block_override_ttl: ?i32 = null,

    /// The way that you want DNS Firewall to block the request, used with the rule
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
    block_response: ?BlockResponse = null,

    /// The confidence threshold for DNS Firewall Advanced. You must provide this
    /// value when you create or update a DNS Firewall Advanced rule. The confidence
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
    confidence_threshold: ?ConfidenceThreshold = null,

    /// A unique string that identifies the request and that allows you to retry
    /// failed requests without the risk of running the operation twice.
    /// `CreatorRequestId` can be any unique string, for example, a date/time stamp.
    creator_request_id: []const u8,

    /// The type of the DNS Firewall Advanced rule. This setting is mutually
    /// exclusive with `FirewallDomainListId` and `FirewallRuleType`. Valid values
    /// are:
    ///
    /// * `DGA`: Domain generation algorithms detection. DGAs are used by attackers
    ///   to generate a large number of domains to launch malware attacks.
    ///
    /// * `DNS_TUNNELING`: DNS tunneling detection. DNS tunneling is used by
    ///   attackers to exfiltrate data from the client by using the DNS tunnel
    ///   without making a network connection to the client.
    ///
    /// * `DICTIONARY_DGA`: Dictionary-based domain generation algorithms detection.
    ///   Dictionary DGAs use wordlists to generate domains that appear more
    ///   legitimate, making them harder to detect than traditional DGAs.
    dns_threat_protection: ?DnsThreatProtection = null,

    /// The ID of the domain list that you want to use in the rule. This setting is
    /// mutually exclusive with `DnsThreatProtection` and `FirewallRuleType`.
    firewall_domain_list_id: ?[]const u8 = null,

    /// How you want the rule to evaluate DNS redirection in the DNS redirection
    /// chain, such as CNAME or DNAME.
    ///
    /// `INSPECT_REDIRECTION_DOMAIN`: (Default) inspects all domains in the
    /// redirection chain. The individual domains in the redirection chain must be
    /// added to the domain list.
    ///
    /// `TRUST_REDIRECTION_DOMAIN`: Inspects only the first domain in the
    /// redirection chain. You don't need to add the subsequent domains in the
    /// redirection list to the domain list.
    firewall_domain_redirection_action: ?FirewallDomainRedirectionAction = null,

    /// The unique identifier of the firewall rule group where you want to create
    /// the rule.
    firewall_rule_group_id: []const u8,

    /// The rule type configuration for the firewall rule. This is a tagged union —
    /// set exactly one of its members. This setting is mutually exclusive with the
    /// top-level `FirewallDomainListId` and `DnsThreatProtection` fields. Use one
    /// of:
    ///
    /// * `FirewallAdvancedContentCategory` — match an Amazon Web Services-managed
    ///   content category (for example, `VIOLENCE_AND_HATE_SPEECH`).
    ///
    /// * `FirewallAdvancedThreatCategory` — match an Amazon Web Services-managed
    ///   advanced threat category (for example, `PHISHING`).
    ///
    /// * `DnsThreatProtection` — match a built-in DNS Firewall Advanced threat
    ///   detector (`DGA`, `DNS_TUNNELING`, or `DICTIONARY_DGA`).
    ///
    /// * `PartnerThreatProtection` — match a third-party threat feed delivered
    ///   through Amazon Web Services Marketplace. The selected partner must be an
    ///   active subscription on the calling account.
    ///
    /// To enumerate the values supported in your account, call
    /// ListFirewallRuleTypes.
    firewall_rule_type: ?FirewallRuleType = null,

    /// A name that lets you identify the rule in the rule group.
    name: []const u8,

    /// The setting that determines the processing order of the rule in the rule
    /// group. DNS Firewall processes the rules in a rule group by order of
    /// priority, starting from the lowest setting.
    priority: i32,

    /// The DNS query type you want the rule to evaluate. Allowed values are:
    ///
    /// * A: Returns an IPv4 address.
    ///
    /// * AAAA: Returns an IPv6 address.
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
    ///   The values must be defined as TYPENUMBER, where the NUMBER can be 1-65534,
    ///   for example, TYPE28. For more information, see [List of DNS record
    ///   types](https://en.wikipedia.org/wiki/List_of_DNS_record_types).
    qtype: ?[]const u8 = null,

    pub const json_field_names = .{
        .action = "Action",
        .block_override_dns_type = "BlockOverrideDnsType",
        .block_override_domain = "BlockOverrideDomain",
        .block_override_ttl = "BlockOverrideTtl",
        .block_response = "BlockResponse",
        .confidence_threshold = "ConfidenceThreshold",
        .creator_request_id = "CreatorRequestId",
        .dns_threat_protection = "DnsThreatProtection",
        .firewall_domain_list_id = "FirewallDomainListId",
        .firewall_domain_redirection_action = "FirewallDomainRedirectionAction",
        .firewall_rule_group_id = "FirewallRuleGroupId",
        .firewall_rule_type = "FirewallRuleType",
        .name = "Name",
        .priority = "Priority",
        .qtype = "Qtype",
    };
};
