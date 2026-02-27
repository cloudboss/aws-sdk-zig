/// The domain unit filter of the project grant filter.
pub const DomainUnitFilterForProject = struct {
    /// The domain unit ID to use in the filter.
    domain_unit: []const u8,

    /// Specifies whether to include child domain units.
    include_child_domain_units: bool = false,

    pub const json_field_names = .{
        .domain_unit = "domainUnit",
        .include_child_domain_units = "includeChildDomainUnits",
    };
};
