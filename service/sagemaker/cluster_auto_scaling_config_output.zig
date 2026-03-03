const ClusterAutoScalerType = @import("cluster_auto_scaler_type.zig").ClusterAutoScalerType;
const ClusterAutoScalingMode = @import("cluster_auto_scaling_mode.zig").ClusterAutoScalingMode;
const ClusterAutoScalingStatus = @import("cluster_auto_scaling_status.zig").ClusterAutoScalingStatus;

/// The autoscaling configuration and status information for a HyperPod cluster.
pub const ClusterAutoScalingConfigOutput = struct {
    /// The type of autoscaler configured for the cluster.
    auto_scaler_type: ?ClusterAutoScalerType = null,

    /// If the autoscaling status is `Failed`, this field contains a message
    /// describing the failure.
    failure_message: ?[]const u8 = null,

    /// Describes whether autoscaling is enabled or disabled for the cluster.
    mode: ClusterAutoScalingMode,

    /// The current status of the autoscaling configuration. Valid values are
    /// `InService`, `Failed`, `Creating`, and `Deleting`.
    status: ClusterAutoScalingStatus,

    pub const json_field_names = .{
        .auto_scaler_type = "AutoScalerType",
        .failure_message = "FailureMessage",
        .mode = "Mode",
        .status = "Status",
    };
};
