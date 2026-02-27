const KubernetesUserDetails = @import("kubernetes_user_details.zig").KubernetesUserDetails;
const KubernetesWorkloadDetails = @import("kubernetes_workload_details.zig").KubernetesWorkloadDetails;

/// Details about Kubernetes resources such as a Kubernetes user or workload
/// resource involved
/// in a Kubernetes finding.
pub const KubernetesDetails = struct {
    /// Details about the Kubernetes user involved in a Kubernetes finding.
    kubernetes_user_details: ?KubernetesUserDetails,

    /// Details about the Kubernetes workload involved in a Kubernetes finding.
    kubernetes_workload_details: ?KubernetesWorkloadDetails,

    pub const json_field_names = .{
        .kubernetes_user_details = "KubernetesUserDetails",
        .kubernetes_workload_details = "KubernetesWorkloadDetails",
    };
};
