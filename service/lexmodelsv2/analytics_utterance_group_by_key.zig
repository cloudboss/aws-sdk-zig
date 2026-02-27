const AnalyticsUtteranceField = @import("analytics_utterance_field.zig").AnalyticsUtteranceField;

/// Contains the category by which the utterance analytics were grouped and the
/// values for that category.
pub const AnalyticsUtteranceGroupByKey = struct {
    /// The category by which the utterance analytics were grouped.
    name: ?AnalyticsUtteranceField,

    /// A member of the category by which the utterance analytics were grouped.
    value: ?[]const u8,

    pub const json_field_names = .{
        .name = "name",
        .value = "value",
    };
};
