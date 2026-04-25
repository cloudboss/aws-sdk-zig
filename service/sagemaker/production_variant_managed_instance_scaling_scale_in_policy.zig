const ManagedInstanceScalingScaleInStrategy = @import("managed_instance_scaling_scale_in_strategy.zig").ManagedInstanceScalingScaleInStrategy;

/// Configures the scale-in behavior for managed instance scaling.
pub const ProductionVariantManagedInstanceScalingScaleInPolicy = struct {
    /// The cooldown period, in minutes, after the last endpoint operation before
    /// the endpoint evaluates consolidation scale-in opportunities.
    ///
    /// Default value: `20`.
    cooldown_in_minutes: ?i32 = null,

    /// The maximum number of instances that the endpoint can terminate at a time
    /// during a consolidation scale-in operation.
    ///
    /// Default value: `1`.
    maximum_step_size: ?i32 = null,

    /// The strategy for scaling in instances.
    ///
    /// **IDLE_RELEASE**
    ///
    /// Releases instances that have no hosted inference component copies.
    ///
    /// **CONSOLIDATION**
    ///
    /// Consolidates inference component copies onto fewer instances to release more
    /// instances. Consolidation honors the scheduling configuration of each
    /// inference component. For example, if an inference component specifies
    /// Availability Zone balance, consolidation only proceeds when the resulting
    /// distribution does not increase the imbalance.
    strategy: ManagedInstanceScalingScaleInStrategy,

    pub const json_field_names = .{
        .cooldown_in_minutes = "CooldownInMinutes",
        .maximum_step_size = "MaximumStepSize",
        .strategy = "Strategy",
    };
};
