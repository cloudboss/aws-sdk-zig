const AnalyticsIntentField = @import("analytics_intent_field.zig").AnalyticsIntentField;

/// Contains the category by which to group the intents.
pub const AnalyticsIntentGroupBySpecification = struct {
    /// Specifies whether to group the intent stages by their name or their end
    /// state.
    name: AnalyticsIntentField,

    pub const json_field_names = .{
        .name = "name",
    };
};
