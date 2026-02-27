const AggregatedUtterancesFilterName = @import("aggregated_utterances_filter_name.zig").AggregatedUtterancesFilterName;
const AggregatedUtterancesFilterOperator = @import("aggregated_utterances_filter_operator.zig").AggregatedUtterancesFilterOperator;

/// Filters responses returned by the
/// `ListAggregatedUtterances` operation.
pub const AggregatedUtterancesFilter = struct {
    /// The name of the field to filter the utterance list.
    name: AggregatedUtterancesFilterName,

    /// The operator to use for the filter. Specify `EQ` when the
    /// `ListAggregatedUtterances` operation should return only
    /// utterances that equal the specified value. Specify `CO` when
    /// the `ListAggregatedUtterances` operation should return
    /// utterances that contain the specified value.
    operator: AggregatedUtterancesFilterOperator,

    /// The value to use for filtering the list of bots.
    values: []const []const u8,

    pub const json_field_names = .{
        .name = "name",
        .operator = "operator",
        .values = "values",
    };
};
