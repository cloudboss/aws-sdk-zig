const InstanceRefreshLivePoolProgress = @import("instance_refresh_live_pool_progress.zig").InstanceRefreshLivePoolProgress;
const InstanceRefreshWarmPoolProgress = @import("instance_refresh_warm_pool_progress.zig").InstanceRefreshWarmPoolProgress;

/// Reports progress on replacing instances in an Auto Scaling group that has a
/// warm pool. This
/// includes separate details for instances in the warm pool and instances in
/// the Auto Scaling group
/// (the live pool).
pub const InstanceRefreshProgressDetails = struct {
    /// Reports progress on replacing instances that are in the Auto Scaling group.
    live_pool_progress: ?InstanceRefreshLivePoolProgress,

    /// Reports progress on replacing instances that are in the warm pool.
    warm_pool_progress: ?InstanceRefreshWarmPoolProgress,
};
