const InstanceReusePolicy = @import("instance_reuse_policy.zig").InstanceReusePolicy;
const WarmPoolState = @import("warm_pool_state.zig").WarmPoolState;
const WarmPoolStatus = @import("warm_pool_status.zig").WarmPoolStatus;

/// Describes a warm pool configuration.
pub const WarmPoolConfiguration = struct {
    /// The instance reuse policy.
    instance_reuse_policy: ?InstanceReusePolicy = null,

    /// The maximum number of instances that are allowed to be in the warm pool or
    /// in any
    /// state except `Terminated` for the Auto Scaling group.
    max_group_prepared_capacity: ?i32 = null,

    /// The minimum number of instances to maintain in the warm pool.
    min_size: ?i32 = null,

    /// The instance state to transition to after the lifecycle actions are
    /// complete.
    pool_state: ?WarmPoolState = null,

    /// The status of a warm pool that is marked for deletion.
    status: ?WarmPoolStatus = null,
};
