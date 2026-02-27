/// Specifies whether to create a project from project profile policy grant
/// details.
pub const CreateProjectFromProjectProfilePolicyGrantDetail = struct {
    /// Specifies whether to include child domain units when creating a project from
    /// project profile policy grant details
    include_child_domain_units: ?bool,

    /// Specifies project profiles when creating a project from project profile
    /// policy grant details
    project_profiles: ?[]const []const u8,

    pub const json_field_names = .{
        .include_child_domain_units = "includeChildDomainUnits",
        .project_profiles = "projectProfiles",
    };
};
