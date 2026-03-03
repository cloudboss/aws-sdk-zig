const ArgoCdNetworkAccessConfigRequest = @import("argo_cd_network_access_config_request.zig").ArgoCdNetworkAccessConfigRequest;
const UpdateRoleMappings = @import("update_role_mappings.zig").UpdateRoleMappings;

/// Configuration updates for an Argo CD capability. You only need to specify
/// the fields you want to update.
pub const UpdateArgoCdConfig = struct {
    /// Updated network access configuration for the Argo CD capability's managed
    /// API server endpoint. You can add or remove VPC endpoint associations to
    /// control which VPCs have private access to the Argo CD server.
    network_access: ?ArgoCdNetworkAccessConfigRequest = null,

    /// Updated RBAC role mappings for the Argo CD capability. You can add, update,
    /// or remove role mappings.
    rbac_role_mappings: ?UpdateRoleMappings = null,

    pub const json_field_names = .{
        .network_access = "networkAccess",
        .rbac_role_mappings = "rbacRoleMappings",
    };
};
