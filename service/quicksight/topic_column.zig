const DefaultAggregation = @import("default_aggregation.zig").DefaultAggregation;
const AuthorSpecifiedAggregation = @import("author_specified_aggregation.zig").AuthorSpecifiedAggregation;
const CellValueSynonym = @import("cell_value_synonym.zig").CellValueSynonym;
const ColumnDataRole = @import("column_data_role.zig").ColumnDataRole;
const ComparativeOrder = @import("comparative_order.zig").ComparativeOrder;
const DefaultFormatting = @import("default_formatting.zig").DefaultFormatting;
const SemanticType = @import("semantic_type.zig").SemanticType;
const TopicTimeGranularity = @import("topic_time_granularity.zig").TopicTimeGranularity;

/// Represents a column in a dataset.
pub const TopicColumn = struct {
    /// The type of aggregation that is performed on the column data when
    /// it's queried.
    aggregation: ?DefaultAggregation = null,

    /// The list of aggregation types that are allowed for the column. Valid values
    /// for this
    /// structure are `COUNT`, `DISTINCT_COUNT`, `MIN`,
    /// `MAX`, `MEDIAN`, `SUM`, `AVERAGE`,
    /// `STDEV`, `STDEVP`, `VAR`,
    /// `VARP`,
    /// and `PERCENTILE`.
    allowed_aggregations: ?[]const AuthorSpecifiedAggregation = null,

    /// The other names or aliases for the column cell value.
    cell_value_synonyms: ?[]const CellValueSynonym = null,

    /// The role of the column in the data. Valid values are `DIMENSION` and
    /// `MEASURE`.
    column_data_role: ?ColumnDataRole = null,

    /// A description of the column and its contents.
    column_description: ?[]const u8 = null,

    /// A user-friendly name for the column.
    column_friendly_name: ?[]const u8 = null,

    /// The name of the column.
    column_name: []const u8,

    /// The other names or aliases for the column.
    column_synonyms: ?[]const []const u8 = null,

    /// The order in which data is displayed for the column when
    /// it's used in a comparative context.
    comparative_order: ?ComparativeOrder = null,

    /// The default formatting used for values in the column.
    default_formatting: ?DefaultFormatting = null,

    /// A Boolean value that indicates whether the column shows in the autocomplete
    /// functionality.
    disable_indexing: ?bool = null,

    /// A Boolean value that indicates whether the column is included in the query
    /// results.
    is_included_in_topic: bool = false,

    /// A Boolean
    /// value that indicates whether to aggregate the column data when
    /// it's used in a filter context.
    never_aggregate_in_filter: bool = false,

    /// The non additive value for the column.
    non_additive: ?bool = null,

    /// The list of aggregation types that are not allowed for the column. Valid
    /// values for this
    /// structure are `COUNT`, `DISTINCT_COUNT`, `MIN`,
    /// `MAX`, `MEDIAN`, `SUM`, `AVERAGE`,
    /// `STDEV`, `STDEVP`, `VAR`,
    /// `VARP`,
    /// and `PERCENTILE`.
    not_allowed_aggregations: ?[]const AuthorSpecifiedAggregation = null,

    /// The semantic type of data contained in the column.
    semantic_type: ?SemanticType = null,

    /// The level of time precision that is used to aggregate `DateTime` values.
    time_granularity: ?TopicTimeGranularity = null,

    pub const json_field_names = .{
        .aggregation = "Aggregation",
        .allowed_aggregations = "AllowedAggregations",
        .cell_value_synonyms = "CellValueSynonyms",
        .column_data_role = "ColumnDataRole",
        .column_description = "ColumnDescription",
        .column_friendly_name = "ColumnFriendlyName",
        .column_name = "ColumnName",
        .column_synonyms = "ColumnSynonyms",
        .comparative_order = "ComparativeOrder",
        .default_formatting = "DefaultFormatting",
        .disable_indexing = "DisableIndexing",
        .is_included_in_topic = "IsIncludedInTopic",
        .never_aggregate_in_filter = "NeverAggregateInFilter",
        .non_additive = "NonAdditive",
        .not_allowed_aggregations = "NotAllowedAggregations",
        .semantic_type = "SemanticType",
        .time_granularity = "TimeGranularity",
    };
};
