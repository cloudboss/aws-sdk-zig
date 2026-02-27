const ClusterKubernetesTaintEffect = @import("cluster_kubernetes_taint_effect.zig").ClusterKubernetesTaintEffect;

/// A Kubernetes taint that can be applied to cluster nodes.
pub const ClusterKubernetesTaint = struct {
    /// The effect of the taint. Valid values are `NoSchedule`, `PreferNoSchedule`,
    /// and `NoExecute`.
    effect: ClusterKubernetesTaintEffect,

    /// The key of the taint.
    key: []const u8,

    /// The value of the taint.
    value: ?[]const u8,

    pub const json_field_names = .{
        .effect = "Effect",
        .key = "Key",
        .value = "Value",
    };
};
