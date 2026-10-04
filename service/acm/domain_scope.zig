const DomainScopeOption = @import("domain_scope_option.zig").DomainScopeOption;

/// Specifies the scope of domain validation.
pub const DomainScope = struct {
    /// Whether validation applies to the exact domain.
    exact_domain: ?DomainScopeOption = null,

    /// Whether validation applies to subdomains.
    subdomains: ?DomainScopeOption = null,

    /// Whether validation applies to wildcard domains.
    wildcards: ?DomainScopeOption = null,

    pub const json_field_names = .{
        .exact_domain = "ExactDomain",
        .subdomains = "Subdomains",
        .wildcards = "Wildcards",
    };
};
