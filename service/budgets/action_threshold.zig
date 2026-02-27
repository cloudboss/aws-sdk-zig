const ThresholdType = @import("threshold_type.zig").ThresholdType;

/// The trigger threshold of the action.
pub const ActionThreshold = struct {
    action_threshold_type: ThresholdType,

    action_threshold_value: f64 = 0,

    pub const json_field_names = .{
        .action_threshold_type = "ActionThresholdType",
        .action_threshold_value = "ActionThresholdValue",
    };
};
