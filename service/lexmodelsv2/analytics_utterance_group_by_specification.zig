const AnalyticsUtteranceField = @import("analytics_utterance_field.zig").AnalyticsUtteranceField;

/// Contains the category by which to group the utterances.
pub const AnalyticsUtteranceGroupBySpecification = struct {
    /// Specifies whether to group the utterances by their text or their state.
    name: AnalyticsUtteranceField,

    pub const json_field_names = .{
        .name = "name",
    };
};
