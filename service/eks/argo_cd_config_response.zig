const ArgoCdAwsIdcConfigResponse = @import("argo_cd_aws_idc_config_response.zig").ArgoCdAwsIdcConfigResponse;
const ArgoCdNetworkAccessConfigResponse = @import("argo_cd_network_access_config_response.zig").ArgoCdNetworkAccessConfigResponse;
const ArgoCdRoleMapping = @import("argo_cd_role_mapping.zig").ArgoCdRoleMapping;

/// The response object containing Argo CD configuration details, including the
/// server URL that you use to access the Argo CD web interface and API.
pub const ArgoCdConfigResponse = struct {
    /// The IAM Identity CenterIAM; Identity Center integration configuration.
    aws_idc: ?ArgoCdAwsIdcConfigResponse,

    /// The Kubernetes namespace where Argo CD resources are monitored by your Argo
    /// CD Capability.
    namespace: ?[]const u8,

    /// The network access configuration for the Argo CD capability's managed API
    /// server endpoint. If VPC endpoint IDs are specified, public access is blocked
    /// and the Argo CD server is only accessible through the specified VPC
    /// endpoints.
    network_access: ?ArgoCdNetworkAccessConfigResponse,

    /// The list of role mappings that define which IAM Identity CenterIAM; Identity
    /// Center users or groups have which Argo CD roles.
    rbac_role_mappings: ?[]const ArgoCdRoleMapping,

    /// The URL of the Argo CD server. Use this URL to access the Argo CD web
    /// interface and API.
    server_url: ?[]const u8,

    pub const json_field_names = .{
        .aws_idc = "awsIdc",
        .namespace = "namespace",
        .network_access = "networkAccess",
        .rbac_role_mappings = "rbacRoleMappings",
        .server_url = "serverUrl",
    };
};
