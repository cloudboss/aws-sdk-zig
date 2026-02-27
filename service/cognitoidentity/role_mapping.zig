const AmbiguousRoleResolutionType = @import("ambiguous_role_resolution_type.zig").AmbiguousRoleResolutionType;
const RulesConfigurationType = @import("rules_configuration_type.zig").RulesConfigurationType;
const RoleMappingType = @import("role_mapping_type.zig").RoleMappingType;

/// A role mapping.
pub const RoleMapping = struct {
    /// If you specify Token or Rules as the `Type`,
    /// `AmbiguousRoleResolution` is required.
    ///
    /// Specifies the action to be taken if either no rules match the claim value
    /// for the
    /// `Rules` type, or there is no `cognito:preferred_role` claim and
    /// there are multiple `cognito:roles` matches for the `Token`
    /// type.
    ambiguous_role_resolution: ?AmbiguousRoleResolutionType,

    /// The rules to be used for mapping users to roles.
    ///
    /// If you specify Rules as the role mapping type, `RulesConfiguration` is
    /// required.
    rules_configuration: ?RulesConfigurationType,

    /// The role mapping type. Token will use `cognito:roles` and
    /// `cognito:preferred_role` claims from the Cognito identity provider token to
    /// map groups to roles. Rules will attempt to match claims from the token to
    /// map to a
    /// role.
    type: RoleMappingType,

    pub const json_field_names = .{
        .ambiguous_role_resolution = "AmbiguousRoleResolution",
        .rules_configuration = "RulesConfiguration",
        .type = "Type",
    };
};
