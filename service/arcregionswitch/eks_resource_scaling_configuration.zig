const aws = @import("aws");

const EksCapacityMonitoringApproach = @import("eks_capacity_monitoring_approach.zig").EksCapacityMonitoringApproach;
const EksCluster = @import("eks_cluster.zig").EksCluster;
const KubernetesResourceType = @import("kubernetes_resource_type.zig").KubernetesResourceType;
const KubernetesScalingResource = @import("kubernetes_scaling_resource.zig").KubernetesScalingResource;
const EksResourceScalingUngraceful = @import("eks_resource_scaling_ungraceful.zig").EksResourceScalingUngraceful;

/// The Amazon Web Services EKS resource scaling configuration.
pub const EksResourceScalingConfiguration = struct {
    /// The monitoring approach for the configuration, that is, whether it was
    /// sampled in the last 24 hours or autoscaled in the last 24 hours.
    capacity_monitoring_approach: EksCapacityMonitoringApproach = "sampledMaxInLast24Hours",

    /// The clusters for the configuration.
    eks_clusters: ?[]const EksCluster,

    /// The Kubernetes resource type for the configuration.
    kubernetes_resource_type: KubernetesResourceType,

    /// The scaling resources for the configuration.
    scaling_resources: ?[]const []const aws.map.MapEntry([]const aws.map.MapEntry(KubernetesScalingResource)),

    /// The target percentage for the configuration.
    target_percent: i32 = 100,

    /// The timeout value specified for the configuration.
    timeout_minutes: i32 = 60,

    /// The settings for ungraceful execution.
    ungraceful: ?EksResourceScalingUngraceful,

    pub const json_field_names = .{
        .capacity_monitoring_approach = "capacityMonitoringApproach",
        .eks_clusters = "eksClusters",
        .kubernetes_resource_type = "kubernetesResourceType",
        .scaling_resources = "scalingResources",
        .target_percent = "targetPercent",
        .timeout_minutes = "timeoutMinutes",
        .ungraceful = "ungraceful",
    };
};
