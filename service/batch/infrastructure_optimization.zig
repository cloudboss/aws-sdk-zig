/// The infrastructure optimization configuration for an Amazon ECS Managed
/// Instances capacity
/// provider. Specifies the idle-instance scale-in behavior.
pub const InfrastructureOptimization = struct {
    /// The number of seconds an instance can remain idle before it is terminated.
    /// Valid
    /// values are `-1` or `0` to `3600`. Use `-1` as a
    /// special value to disable scale-in (instances are never terminated for being
    /// idle). If not
    /// specified, a default value applies.
    scale_in_after: ?i32 = null,

    pub const json_field_names = .{
        .scale_in_after = "scaleInAfter",
    };
};
