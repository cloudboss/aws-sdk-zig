pub const FirewallDomainRedirectionAction = enum {
    inspect_redirection_domain,
    trust_redirection_domain,

    pub const json_field_names = .{
        .inspect_redirection_domain = "INSPECT_REDIRECTION_DOMAIN",
        .trust_redirection_domain = "TRUST_REDIRECTION_DOMAIN",
    };
};
