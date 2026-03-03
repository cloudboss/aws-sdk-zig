const AwsApiCallAction = @import("aws_api_call_action.zig").AwsApiCallAction;
const DnsRequestAction = @import("dns_request_action.zig").DnsRequestAction;
const KubernetesApiCallAction = @import("kubernetes_api_call_action.zig").KubernetesApiCallAction;
const KubernetesPermissionCheckedDetails = @import("kubernetes_permission_checked_details.zig").KubernetesPermissionCheckedDetails;
const KubernetesRoleBindingDetails = @import("kubernetes_role_binding_details.zig").KubernetesRoleBindingDetails;
const KubernetesRoleDetails = @import("kubernetes_role_details.zig").KubernetesRoleDetails;
const NetworkConnectionAction = @import("network_connection_action.zig").NetworkConnectionAction;
const PortProbeAction = @import("port_probe_action.zig").PortProbeAction;
const RdsLoginAttemptAction = @import("rds_login_attempt_action.zig").RdsLoginAttemptAction;

/// Contains information about actions.
pub const Action = struct {
    /// The GuardDuty finding activity type.
    action_type: ?[]const u8 = null,

    /// Information about the AWS_API_CALL action described in this finding.
    aws_api_call_action: ?AwsApiCallAction = null,

    /// Information about the DNS_REQUEST action described in this finding.
    dns_request_action: ?DnsRequestAction = null,

    /// Information about the Kubernetes API call action described in this finding.
    kubernetes_api_call_action: ?KubernetesApiCallAction = null,

    /// Information whether the user has the permission to use a specific Kubernetes
    /// API.
    kubernetes_permission_checked_details: ?KubernetesPermissionCheckedDetails = null,

    /// Information about the role binding that grants the permission defined in a
    /// Kubernetes role.
    kubernetes_role_binding_details: ?KubernetesRoleBindingDetails = null,

    /// Information about the Kubernetes role name and role type.
    kubernetes_role_details: ?KubernetesRoleDetails = null,

    /// Information about the NETWORK_CONNECTION action described in this finding.
    network_connection_action: ?NetworkConnectionAction = null,

    /// Information about the PORT_PROBE action described in this finding.
    port_probe_action: ?PortProbeAction = null,

    /// Information about `RDS_LOGIN_ATTEMPT` action described in this finding.
    rds_login_attempt_action: ?RdsLoginAttemptAction = null,

    pub const json_field_names = .{
        .action_type = "ActionType",
        .aws_api_call_action = "AwsApiCallAction",
        .dns_request_action = "DnsRequestAction",
        .kubernetes_api_call_action = "KubernetesApiCallAction",
        .kubernetes_permission_checked_details = "KubernetesPermissionCheckedDetails",
        .kubernetes_role_binding_details = "KubernetesRoleBindingDetails",
        .kubernetes_role_details = "KubernetesRoleDetails",
        .network_connection_action = "NetworkConnectionAction",
        .port_probe_action = "PortProbeAction",
        .rds_login_attempt_action = "RdsLoginAttemptAction",
    };
};
