const ArgoCdAwsIdcConfigRequest = @import("argo_cd_aws_idc_config_request.zig").ArgoCdAwsIdcConfigRequest;
const ArgoCdNetworkAccessConfigRequest = @import("argo_cd_network_access_config_request.zig").ArgoCdNetworkAccessConfigRequest;
const ArgoCdRoleMapping = @import("argo_cd_role_mapping.zig").ArgoCdRoleMapping;

/// Configuration settings for an Argo CD capability. This includes the
/// Kubernetes namespace, IAM Identity CenterIAM; Identity Center integration,
/// RBAC role mappings, and network access configuration.
pub const ArgoCdConfigRequest = struct {
    /// Configuration for IAM Identity CenterIAM; Identity Center integration. When
    /// configured, users can authenticate to Argo CD using their IAM Identity
    /// CenterIAM; Identity Center credentials.
    aws_idc: ArgoCdAwsIdcConfigRequest,

    /// The Kubernetes namespace where Argo CD resources will be created. If not
    /// specified, the default namespace is used.
    namespace: ?[]const u8 = null,

    /// Configuration for network access to the Argo CD capability's managed API
    /// server endpoint. By default, the Argo CD server is accessible via a public
    /// endpoint. You can optionally specify one or more VPC endpoint IDs to enable
    /// private connectivity from your VPCs. When VPC endpoints are configured,
    /// public access is blocked and the Argo CD server is only accessible through
    /// the specified VPC endpoints.
    network_access: ?ArgoCdNetworkAccessConfigRequest = null,

    /// A list of role mappings that define which IAM Identity CenterIAM; Identity
    /// Center users or groups have which Argo CD roles. Each mapping associates an
    /// Argo CD role (`ADMIN`, `EDITOR`, or `VIEWER`) with one or more IAM Identity
    /// CenterIAM; Identity Center identities.
    rbac_role_mappings: ?[]const ArgoCdRoleMapping = null,

    pub const json_field_names = .{
        .aws_idc = "awsIdc",
        .namespace = "namespace",
        .network_access = "networkAccess",
        .rbac_role_mappings = "rbacRoleMappings",
    };
};
