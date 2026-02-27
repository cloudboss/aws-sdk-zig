const AnalyticsIntentField = @import("analytics_intent_field.zig").AnalyticsIntentField;

/// Contains the category by which the intent analytics were grouped and a
/// member of that category.
pub const AnalyticsIntentGroupByKey = struct {
    /// A category by which the intent analytics were grouped.
    name: ?AnalyticsIntentField,

    /// A member of the category by which the intent analytics were grouped.
    value: ?[]const u8,

    pub const json_field_names = .{
        .name = "name",
        .value = "value",
    };
};
