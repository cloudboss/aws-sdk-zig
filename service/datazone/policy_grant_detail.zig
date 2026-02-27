const AddToProjectMemberPoolPolicyGrantDetail = @import("add_to_project_member_pool_policy_grant_detail.zig").AddToProjectMemberPoolPolicyGrantDetail;
const CreateAssetTypePolicyGrantDetail = @import("create_asset_type_policy_grant_detail.zig").CreateAssetTypePolicyGrantDetail;
const CreateDomainUnitPolicyGrantDetail = @import("create_domain_unit_policy_grant_detail.zig").CreateDomainUnitPolicyGrantDetail;
const Unit = @import("unit.zig").Unit;
const CreateEnvironmentProfilePolicyGrantDetail = @import("create_environment_profile_policy_grant_detail.zig").CreateEnvironmentProfilePolicyGrantDetail;
const CreateFormTypePolicyGrantDetail = @import("create_form_type_policy_grant_detail.zig").CreateFormTypePolicyGrantDetail;
const CreateGlossaryPolicyGrantDetail = @import("create_glossary_policy_grant_detail.zig").CreateGlossaryPolicyGrantDetail;
const CreateProjectPolicyGrantDetail = @import("create_project_policy_grant_detail.zig").CreateProjectPolicyGrantDetail;
const CreateProjectFromProjectProfilePolicyGrantDetail = @import("create_project_from_project_profile_policy_grant_detail.zig").CreateProjectFromProjectProfilePolicyGrantDetail;
const OverrideDomainUnitOwnersPolicyGrantDetail = @import("override_domain_unit_owners_policy_grant_detail.zig").OverrideDomainUnitOwnersPolicyGrantDetail;
const OverrideProjectOwnersPolicyGrantDetail = @import("override_project_owners_policy_grant_detail.zig").OverrideProjectOwnersPolicyGrantDetail;
const UseAssetTypePolicyGrantDetail = @import("use_asset_type_policy_grant_detail.zig").UseAssetTypePolicyGrantDetail;

/// The details of the policy grant.
pub const PolicyGrantDetail = union(enum) {
    /// Specifies that the policy grant is to be added to the members of the
    /// project.
    add_to_project_member_pool: ?AddToProjectMemberPoolPolicyGrantDetail,
    /// Specifies that this is a create asset type policy.
    create_asset_type: ?CreateAssetTypePolicyGrantDetail,
    /// Specifies that this is a create domain unit policy.
    create_domain_unit: ?CreateDomainUnitPolicyGrantDetail,
    /// Specifies that this is a create environment policy.
    create_environment: ?Unit,
    create_environment_from_blueprint: ?Unit,
    /// Specifies that this is a create environment profile policy.
    create_environment_profile: ?CreateEnvironmentProfilePolicyGrantDetail,
    /// Specifies that this is a create form type policy.
    create_form_type: ?CreateFormTypePolicyGrantDetail,
    /// Specifies that this is a create glossary policy.
    create_glossary: ?CreateGlossaryPolicyGrantDetail,
    /// Specifies that this is a create project policy.
    create_project: ?CreateProjectPolicyGrantDetail,
    /// Specifies whether to create a project from project profile.
    create_project_from_project_profile: ?CreateProjectFromProjectProfilePolicyGrantDetail,
    /// Specifies that this is the delegation of the create environment profile
    /// policy.
    delegate_create_environment_profile: ?Unit,
    /// Specifies whether to override domain unit owners.
    override_domain_unit_owners: ?OverrideDomainUnitOwnersPolicyGrantDetail,
    /// Specifies whether to override project owners.
    override_project_owners: ?OverrideProjectOwnersPolicyGrantDetail,
    /// Specifies the domain unit(s) whose projects can use this asset type while
    /// creating asset or asset revisions.
    use_asset_type: ?UseAssetTypePolicyGrantDetail,

    pub const json_field_names = .{
        .add_to_project_member_pool = "addToProjectMemberPool",
        .create_asset_type = "createAssetType",
        .create_domain_unit = "createDomainUnit",
        .create_environment = "createEnvironment",
        .create_environment_from_blueprint = "createEnvironmentFromBlueprint",
        .create_environment_profile = "createEnvironmentProfile",
        .create_form_type = "createFormType",
        .create_glossary = "createGlossary",
        .create_project = "createProject",
        .create_project_from_project_profile = "createProjectFromProjectProfile",
        .delegate_create_environment_profile = "delegateCreateEnvironmentProfile",
        .override_domain_unit_owners = "overrideDomainUnitOwners",
        .override_project_owners = "overrideProjectOwners",
        .use_asset_type = "useAssetType",
    };
};
