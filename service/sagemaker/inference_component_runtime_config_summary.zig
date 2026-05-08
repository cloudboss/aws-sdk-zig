const InferenceComponentPlacementStatus = @import("inference_component_placement_status.zig").InferenceComponentPlacementStatus;

/// Details about the runtime settings for the model that is deployed with the
/// inference component.
pub const InferenceComponentRuntimeConfigSummary = struct {
    /// The number of runtime copies of the model container that are currently
    /// deployed.
    current_copy_count: ?i32 = null,

    /// The number of runtime copies of the model container that you requested to
    /// deploy with the inference component.
    desired_copy_count: ?i32 = null,

    /// The placement status of the inference component across instance types. Shows
    /// how the inference component copies are distributed across instance types.
    placement_status: ?[]const InferenceComponentPlacementStatus = null,

    pub const json_field_names = .{
        .current_copy_count = "CurrentCopyCount",
        .desired_copy_count = "DesiredCopyCount",
        .placement_status = "PlacementStatus",
    };
};
