/// The target for the domain unit.
pub const DomainUnitTarget = struct {
    /// The ID of the domain unit.
    domain_unit_id: []const u8,

    /// Specifies whether to apply a rule to the child domain units.
    include_child_domain_units: ?bool = null,

    pub const json_field_names = .{
        .domain_unit_id = "domainUnitId",
        .include_child_domain_units = "includeChildDomainUnits",
    };
};
