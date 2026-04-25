/// Contains information about the DNS_REQUEST action described in this finding.
pub const DnsRequestAction = struct {
    /// Indicates whether the targeted port is blocked.
    blocked: ?bool = null,

    /// The domain information for the DNS query.
    domain: ?[]const u8 = null,

    /// The second and top level domain involved in the activity that potentially
    /// prompted GuardDuty to generate this finding. For a list of top-level and
    /// second-level domains, see [public suffix list](https://publicsuffix.org/).
    domain_with_suffix: ?[]const u8 = null,

    /// The network connection protocol observed in the activity that prompted
    /// GuardDuty to generate the finding.
    protocol: ?[]const u8 = null,

    /// The Amazon Web Services account ID that owns the VPC through which the DNS
    /// request was made.
    vpc_owner_account_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .blocked = "Blocked",
        .domain = "Domain",
        .domain_with_suffix = "DomainWithSuffix",
        .protocol = "Protocol",
        .vpc_owner_account_id = "VpcOwnerAccountId",
    };
};
