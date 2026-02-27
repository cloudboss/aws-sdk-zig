const TriggerMode = @import("trigger_mode.zig").TriggerMode;

/// Specifies the condition under which a signal fetch occurs.
pub const ConditionBasedSignalFetchConfig = struct {
    /// The condition that must be satisfied to trigger a signal fetch.
    condition_expression: []const u8,

    /// Indicates the mode in which the signal fetch is triggered.
    trigger_mode: TriggerMode,

    pub const json_field_names = .{
        .condition_expression = "conditionExpression",
        .trigger_mode = "triggerMode",
    };
};
