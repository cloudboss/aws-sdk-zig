/// The details of the override project owners policy grant.
pub const OverrideProjectOwnersPolicyGrantDetail = struct {
    /// Specifies whether the policy is inherited by child domain units.
    include_child_domain_units: ?bool,

    pub const json_field_names = .{
        .include_child_domain_units = "includeChildDomainUnits",
    };
};
