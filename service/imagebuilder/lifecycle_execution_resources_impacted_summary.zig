/// Contains details for an image resource that was identified for a lifecycle
/// action.
pub const LifecycleExecutionResourcesImpactedSummary = struct {
    /// Indicates whether an image resource that was identified for a lifecycle
    /// action has
    /// associated resources that are also impacted.
    has_impacted_resources: bool = false,

    pub const json_field_names = .{
        .has_impacted_resources = "hasImpactedResources",
    };
};
