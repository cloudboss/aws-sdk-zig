/// Contains an indicator that shows whether the lifecycle execution identified
/// any resources to take lifecycle actions on.
pub const LifecycleExecutionResourcesImpactedSummary = struct {
    /// Indicates whether the lifecycle execution identified any resources to take
    /// lifecycle actions on.
    has_impacted_resources: bool = false,

    pub const json_field_names = .{
        .has_impacted_resources = "hasImpactedResources",
    };
};
