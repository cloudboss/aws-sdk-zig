const AnalyticsIntentStageField = @import("analytics_intent_stage_field.zig").AnalyticsIntentStageField;

/// Contains the category by which the intent stage analytics and the values for
/// that category were grouped.
pub const AnalyticsIntentStageGroupByKey = struct {
    /// A category by which the intent stage analytics were grouped.
    name: ?AnalyticsIntentStageField = null,

    /// A member of the category by which the intent stage analytics were grouped.
    value: ?[]const u8 = null,

    pub const json_field_names = .{
        .name = "name",
        .value = "value",
    };
};
