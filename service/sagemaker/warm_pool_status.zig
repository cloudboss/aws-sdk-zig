const WarmPoolResourceStatus = @import("warm_pool_resource_status.zig").WarmPoolResourceStatus;

/// Status and billing information about the warm pool.
pub const WarmPoolStatus = struct {
    /// The billable time in seconds used by the warm pool. Billable time refers to
    /// the absolute wall-clock time.
    ///
    /// Multiply `ResourceRetainedBillableTimeInSeconds` by the number of instances
    /// (`InstanceCount`) in your training cluster to get the total compute time
    /// SageMaker bills you if you run warm pool training. The formula is as
    /// follows: `ResourceRetainedBillableTimeInSeconds * InstanceCount`.
    resource_retained_billable_time_in_seconds: ?i32 = null,

    /// The name of the matching training job that reused the warm pool.
    reused_by_job: ?[]const u8 = null,

    /// The status of the warm pool.
    ///
    /// * `InUse`: The warm pool is in use for the training job.
    /// * `Available`: The warm pool is available to reuse for a matching training
    ///   job.
    /// * `Reused`: The warm pool moved to a matching training job for reuse.
    /// * `Terminated`: The warm pool is no longer available. Warm pools are
    ///   unavailable if they are terminated by a user, terminated for a patch
    ///   update, or terminated for exceeding the specified
    ///   `KeepAlivePeriodInSeconds`.
    status: WarmPoolResourceStatus,

    pub const json_field_names = .{
        .resource_retained_billable_time_in_seconds = "ResourceRetainedBillableTimeInSeconds",
        .reused_by_job = "ReusedByJob",
        .status = "Status",
    };
};
