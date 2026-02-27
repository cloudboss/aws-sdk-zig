const ArgoCdRoleMapping = @import("argo_cd_role_mapping.zig").ArgoCdRoleMapping;

/// Updates to RBAC role mappings for an Argo CD capability. You can add,
/// update, or remove role mappings in a single operation.
pub const UpdateRoleMappings = struct {
    /// A list of role mappings to add or update. If a mapping for the specified
    /// role already exists, it will be updated with the new identities. If it
    /// doesn't exist, a new mapping will be created.
    add_or_update_role_mappings: ?[]const ArgoCdRoleMapping,

    /// A list of role mappings to remove from the RBAC configuration. Each mapping
    /// specifies an Argo CD role (`ADMIN`, `EDITOR`, or `VIEWER`) and the
    /// identities to remove from that role.
    remove_role_mappings: ?[]const ArgoCdRoleMapping,

    pub const json_field_names = .{
        .add_or_update_role_mappings = "addOrUpdateRoleMappings",
        .remove_role_mappings = "removeRoleMappings",
    };
};
