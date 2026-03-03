const ClusterAutoScalerType = @import("cluster_auto_scaler_type.zig").ClusterAutoScalerType;
const ClusterAutoScalingMode = @import("cluster_auto_scaling_mode.zig").ClusterAutoScalingMode;

/// Specifies the autoscaling configuration for a HyperPod cluster.
pub const ClusterAutoScalingConfig = struct {
    /// The type of autoscaler to use. Currently supported value is `Karpenter`.
    auto_scaler_type: ?ClusterAutoScalerType = null,

    /// Describes whether autoscaling is enabled or disabled for the cluster. Valid
    /// values are `Enable` and `Disable`.
    mode: ClusterAutoScalingMode,

    pub const json_field_names = .{
        .auto_scaler_type = "AutoScalerType",
        .mode = "Mode",
    };
};
