/// The configuration that controls how Amazon ECS optimizes your
/// infrastructure.
pub const InfrastructureOptimization = struct {
    /// This parameter defines the number of seconds Amazon ECS Managed Instances
    /// waits before optimizing EC2 instances that have become idle or
    /// underutilized.
    /// A longer delay increases the likelihood of placing new tasks on idle or
    /// underutilized instances instances, reducing startup time.
    /// A shorter delay helps reduce infrastructure costs by optimizing idle or
    /// underutilized instances,instances more quickly.
    ///
    /// Valid values are:
    ///
    /// * `null` - Uses the default optimization behavior.
    ///
    /// * `-1` - Disables automatic infrastructure optimization.
    ///
    /// * A value between `0` and `3600` (inclusive) - Specifies the number of
    ///   seconds to wait before optimizing instances.
    scale_in_after: ?i32,

    pub const json_field_names = .{
        .scale_in_after = "scaleInAfter",
    };
};
