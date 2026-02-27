const AnalyticsIntentStageField = @import("analytics_intent_stage_field.zig").AnalyticsIntentStageField;

/// Contains the category by which to group the intent stages.
pub const AnalyticsIntentStageGroupBySpecification = struct {
    /// Specifies whether to group the intent stages by their name or the intent to
    /// which the session was switched.
    name: AnalyticsIntentStageField,

    pub const json_field_names = .{
        .name = "name",
    };
};
