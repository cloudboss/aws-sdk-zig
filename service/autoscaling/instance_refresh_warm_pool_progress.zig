/// Reports progress on replacing instances that are in the warm pool.
pub const InstanceRefreshWarmPoolProgress = struct {
    /// The number of instances remaining to update.
    instances_to_update: ?i32 = null,

    /// The percentage of instances in the warm pool that have been replaced. For
    /// each
    /// instance replacement, Amazon EC2 Auto Scaling tracks the instance's health
    /// status and warm-up time.
    /// When the instance's health status changes to healthy and the specified
    /// warm-up time
    /// passes, the instance is considered updated and is added to the percentage
    /// complete.
    percentage_complete: ?i32 = null,
};
