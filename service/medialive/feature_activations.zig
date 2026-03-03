const FeatureActivationsInputPrepareScheduleActions = @import("feature_activations_input_prepare_schedule_actions.zig").FeatureActivationsInputPrepareScheduleActions;
const FeatureActivationsOutputStaticImageOverlayScheduleActions = @import("feature_activations_output_static_image_overlay_schedule_actions.zig").FeatureActivationsOutputStaticImageOverlayScheduleActions;

/// Feature Activations
pub const FeatureActivations = struct {
    /// Enables the Input Prepare feature. You can create Input Prepare actions in
    /// the schedule only if this feature is enabled.
    /// If you disable the feature on an existing schedule, make sure that you first
    /// delete all input prepare actions from the schedule.
    input_prepare_schedule_actions: ?FeatureActivationsInputPrepareScheduleActions = null,

    /// Enables the output static image overlay feature. Enabling this feature
    /// allows you to send channel schedule updates
    /// to display/clear/modify image overlays on an output-by-output bases.
    output_static_image_overlay_schedule_actions: ?FeatureActivationsOutputStaticImageOverlayScheduleActions = null,

    pub const json_field_names = .{
        .input_prepare_schedule_actions = "InputPrepareScheduleActions",
        .output_static_image_overlay_schedule_actions = "OutputStaticImageOverlayScheduleActions",
    };
};
