const AllDomainUnitsGrantFilter = @import("all_domain_units_grant_filter.zig").AllDomainUnitsGrantFilter;

/// The grant filter for the domain unit. In the current release of Amazon
/// DataZone, the only supported filter is the `allDomainUnitsGrantFilter`.
pub const DomainUnitGrantFilter = union(enum) {
    /// Specifies a grant filter containing all domain units.
    all_domain_units_grant_filter: ?AllDomainUnitsGrantFilter,

    pub const json_field_names = .{
        .all_domain_units_grant_filter = "allDomainUnitsGrantFilter",
    };
};
