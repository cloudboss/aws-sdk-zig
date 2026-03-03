const DomainResourceFilter = @import("domain_resource_filter.zig").DomainResourceFilter;

/// An optional filter that narrows the list of objectives to a specific domain.
pub const ObjectiveFilter = struct {
    /// The domain that's used as filter criteria.
    ///
    /// You can use this parameter to specify one domain ARN at a time. Passing
    /// multiple ARNs in the `ObjectiveFilter` isn’t supported.
    domains: ?[]const DomainResourceFilter = null,

    pub const json_field_names = .{
        .domains = "Domains",
    };
};
