const ComputeLimits = @import("compute_limits.zig").ComputeLimits;
const ScalingStrategy = @import("scaling_strategy.zig").ScalingStrategy;

/// Managed scaling policy for an Amazon EMR cluster. The policy specifies the
/// limits for resources that can be added or terminated from a cluster. The
/// policy only
/// applies to the core and task nodes. The master node cannot be scaled after
/// initial
/// configuration.
pub const ManagedScalingPolicy = struct {
    /// The Amazon EC2 unit limits for a managed scaling policy. The managed scaling
    /// activity of a cluster is not allowed to go above or below these limits. The
    /// limit only
    /// applies to the core and task nodes. The master node cannot be scaled after
    /// initial
    /// configuration.
    compute_limits: ?ComputeLimits,

    /// Determines whether a custom scaling utilization performance index can be
    /// set. Possible values include *ADVANCED* or *DEFAULT*.
    scaling_strategy: ?ScalingStrategy,

    /// An integer value that represents an advanced scaling strategy. Setting a
    /// higher value optimizes for performance. Setting a lower value optimizes for
    /// resource conservation. Setting the value
    /// to 50 balances performance and resource conservation. Possible values are 1,
    /// 25, 50, 75, and 100.
    utilization_performance_index: ?i32,

    pub const json_field_names = .{
        .compute_limits = "ComputeLimits",
        .scaling_strategy = "ScalingStrategy",
        .utilization_performance_index = "UtilizationPerformanceIndex",
    };
};
