const AggregatedUtterancesSortAttribute = @import("aggregated_utterances_sort_attribute.zig").AggregatedUtterancesSortAttribute;
const SortOrder = @import("sort_order.zig").SortOrder;

/// Specifies attributes for sorting a list of utterances.
pub const AggregatedUtterancesSortBy = struct {
    /// The utterance attribute to sort by.
    attribute: AggregatedUtterancesSortAttribute,

    /// Specifies whether to sort the aggregated utterances in ascending or
    /// descending order.
    order: SortOrder,

    pub const json_field_names = .{
        .attribute = "attribute",
        .order = "order",
    };
};
