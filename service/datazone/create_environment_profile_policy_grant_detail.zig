/// The details of the policy grant.
pub const CreateEnvironmentProfilePolicyGrantDetail = struct {
    /// The ID of the domain unit.
    domain_unit_id: ?[]const u8,

    pub const json_field_names = .{
        .domain_unit_id = "domainUnitId",
    };
};
