/// Optional. Configuration for a destination queue to which the job can hop
/// once a customer-defined minimum wait time has passed.
pub const HopDestination = struct {
    /// Optional. When you set up a job to use queue hopping, you can specify a
    /// different relative priority for the job in the destination queue. If you
    /// don't specify, the relative priority will remain the same as in the previous
    /// queue.
    priority: ?i32,

    /// Optional unless the job is submitted on the default queue. When you set up a
    /// job to use queue hopping, you can specify a destination queue. This queue
    /// cannot be the original queue to which the job is submitted. If the original
    /// queue isn't the default queue and you don't specify the destination queue,
    /// the job will move to the default queue.
    queue: ?[]const u8,

    /// Required for setting up a job to use queue hopping. Minimum wait time in
    /// minutes until the job can hop to the destination queue. Valid range is 1 to
    /// 4320 minutes, inclusive.
    wait_minutes: ?i32,

    pub const json_field_names = .{
        .priority = "Priority",
        .queue = "Queue",
        .wait_minutes = "WaitMinutes",
    };
};
