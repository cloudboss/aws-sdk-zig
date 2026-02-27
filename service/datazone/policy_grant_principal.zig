const DomainUnitPolicyGrantPrincipal = @import("domain_unit_policy_grant_principal.zig").DomainUnitPolicyGrantPrincipal;
const GroupPolicyGrantPrincipal = @import("group_policy_grant_principal.zig").GroupPolicyGrantPrincipal;
const ProjectPolicyGrantPrincipal = @import("project_policy_grant_principal.zig").ProjectPolicyGrantPrincipal;
const UserPolicyGrantPrincipal = @import("user_policy_grant_principal.zig").UserPolicyGrantPrincipal;

/// The policy grant principal.
pub const PolicyGrantPrincipal = union(enum) {
    /// The domain unit of the policy grant principal.
    domain_unit: ?DomainUnitPolicyGrantPrincipal,
    /// The group of the policy grant principal.
    group: ?GroupPolicyGrantPrincipal,
    /// The project of the policy grant principal.
    project: ?ProjectPolicyGrantPrincipal,
    /// The user of the policy grant principal.
    user: ?UserPolicyGrantPrincipal,

    pub const json_field_names = .{
        .domain_unit = "domainUnit",
        .group = "group",
        .project = "project",
        .user = "user",
    };
};
