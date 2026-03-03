/// The grant details of the override domain unit owners policy.
pub const OverrideDomainUnitOwnersPolicyGrantDetail = struct {
    /// Specifies whether the policy is inherited by child domain units.
    include_child_domain_units: ?bool = null,

    pub const json_field_names = .{
        .include_child_domain_units = "includeChildDomainUnits",
    };
};
