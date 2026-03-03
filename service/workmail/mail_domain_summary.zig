/// The data for a given domain.
pub const MailDomainSummary = struct {
    /// Whether the domain is default or not.
    default_domain: bool = false,

    /// The domain name.
    domain_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .default_domain = "DefaultDomain",
        .domain_name = "DomainName",
    };
};
