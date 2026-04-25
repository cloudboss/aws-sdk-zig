const WarmPoolState = @import("warm_pool_state.zig").WarmPoolState;

/// The configuration for an Amazon EC2 Auto Scaling warm pool attached to an
/// Amazon EKS managed node group. Warm pools maintain pre-initialized EC2
/// instances alongside your Auto Scaling group that have already completed the
/// bootup initialization process and can be kept in a `Stopped`, `Running`, or
/// `Hibernated` state.
pub const WarmPoolConfig = struct {
    /// Specifies whether to attach warm pools on the managed node group. Set to
    /// `true` to enable the warm pool, or `false` to disable and remove it. If not
    /// specified during an update, the current value is preserved.
    enabled: ?bool = null,

    /// The maximum total number of instances across the warm pool and Auto Scaling
    /// group combined. This value controls the total prepared capacity available
    /// for your node group.
    max_group_prepared_capacity: ?i32 = null,

    /// The minimum number of instances to maintain in the warm pool. Default: `0`.
    /// Size your warm pool based on scaling patterns to balance cost and
    /// availability. Start with 10-20% of expected peak capacity.
    min_size: ?i32 = null,

    /// The desired state for warm pool instances. Default: `Stopped`. Valid values
    /// are `Stopped` (most cost-effective with EBS storage costs only), `Running`
    /// (fastest transition time with full EC2 costs), and `Hibernated` (balance
    /// between cost and speed, only supported on specific instance types). Warm
    /// pool instances in the `Hibernated` state are not supported with Bottlerocket
    /// AMIs.
    pool_state: ?WarmPoolState = null,

    /// Indicates whether instances should return to the warm pool during scale-in
    /// events instead of being terminated. Default: `false`. Enable this to reduce
    /// costs by reusing instances. This feature is not supported for Bottlerocket
    /// AMIs.
    reuse_on_scale_in: ?bool = null,

    pub const json_field_names = .{
        .enabled = "enabled",
        .max_group_prepared_capacity = "maxGroupPreparedCapacity",
        .min_size = "minSize",
        .pool_state = "poolState",
        .reuse_on_scale_in = "reuseOnScaleIn",
    };
};
