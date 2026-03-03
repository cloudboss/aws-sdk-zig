/// The details of the policy grant.
pub const CreateFormTypePolicyGrantDetail = struct {
    /// Specifies whether the policy grant is applied to child domain units.
    include_child_domain_units: ?bool = null,

    pub const json_field_names = .{
        .include_child_domain_units = "includeChildDomainUnits",
    };
};
