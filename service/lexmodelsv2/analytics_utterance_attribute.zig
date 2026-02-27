const AnalyticsUtteranceAttributeName = @import("analytics_utterance_attribute_name.zig").AnalyticsUtteranceAttributeName;

/// An object that specifies the last used intent at the time of the utterance
/// as an attribute to return.
pub const AnalyticsUtteranceAttribute = struct {
    /// An attribute to return. The only available attribute is the intent that the
    /// bot mapped the utterance to.
    name: AnalyticsUtteranceAttributeName,

    pub const json_field_names = .{
        .name = "name",
    };
};
