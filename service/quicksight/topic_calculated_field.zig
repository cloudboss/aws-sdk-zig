const DefaultAggregation = @import("default_aggregation.zig").DefaultAggregation;
const AuthorSpecifiedAggregation = @import("author_specified_aggregation.zig").AuthorSpecifiedAggregation;
const CellValueSynonym = @import("cell_value_synonym.zig").CellValueSynonym;
const ColumnDataRole = @import("column_data_role.zig").ColumnDataRole;
const ComparativeOrder = @import("comparative_order.zig").ComparativeOrder;
const DefaultFormatting = @import("default_formatting.zig").DefaultFormatting;
const SemanticType = @import("semantic_type.zig").SemanticType;
const TopicTimeGranularity = @import("topic_time_granularity.zig").TopicTimeGranularity;

/// A structure that represents a calculated field.
pub const TopicCalculatedField = struct {
    /// The default aggregation. Valid values for this structure are `SUM`,
    /// `MAX`, `MIN`, `COUNT`,
    /// `DISTINCT_COUNT`,
    /// and `AVERAGE`.
    aggregation: ?DefaultAggregation = null,

    /// The list of aggregation types that are allowed for the calculated field.
    /// Valid values
    /// for this structure are `COUNT`, `DISTINCT_COUNT`, `MIN`,
    /// `MAX`, `MEDIAN`, `SUM`, `AVERAGE`,
    /// `STDEV`, `STDEVP`, `VAR`,
    /// `VARP`, and `PERCENTILE`.
    allowed_aggregations: ?[]const AuthorSpecifiedAggregation = null,

    /// The calculated field description.
    calculated_field_description: ?[]const u8 = null,

    /// The calculated field name.
    calculated_field_name: []const u8,

    /// The other names or aliases for the calculated field.
    calculated_field_synonyms: ?[]const []const u8 = null,

    /// The other
    /// names or aliases for the calculated field cell value.
    cell_value_synonyms: ?[]const CellValueSynonym = null,

    /// The column data role for a calculated field. Valid values for this structure
    /// are `DIMENSION` and `MEASURE`.
    column_data_role: ?ColumnDataRole = null,

    /// The order in which data is displayed for the calculated field when
    /// it's used in a comparative context.
    comparative_order: ?ComparativeOrder = null,

    /// The default formatting definition.
    default_formatting: ?DefaultFormatting = null,

    /// A Boolean value that indicates if a calculated field is visible in the
    /// autocomplete.
    disable_indexing: ?bool = null,

    /// The calculated field expression.
    expression: []const u8,

    /// A boolean value that indicates if a calculated field is included in the
    /// topic.
    is_included_in_topic: bool = false,

    /// A Boolean value that indicates whether to never aggregate calculated field
    /// in filters.
    never_aggregate_in_filter: bool = false,

    /// The non additive for the table style target.
    non_additive: ?bool = null,

    /// The list of aggregation types that are not allowed for the calculated field.
    /// Valid
    /// values for this structure are `COUNT`, `DISTINCT_COUNT`,
    /// `MIN`, `MAX`, `MEDIAN`, `SUM`,
    /// `AVERAGE`, `STDEV`, `STDEVP`, `VAR`,
    /// `VARP`, and `PERCENTILE`.
    not_allowed_aggregations: ?[]const AuthorSpecifiedAggregation = null,

    /// The semantic type.
    semantic_type: ?SemanticType = null,

    /// The level of time precision that is used to aggregate `DateTime` values.
    time_granularity: ?TopicTimeGranularity = null,

    pub const json_field_names = .{
        .aggregation = "Aggregation",
        .allowed_aggregations = "AllowedAggregations",
        .calculated_field_description = "CalculatedFieldDescription",
        .calculated_field_name = "CalculatedFieldName",
        .calculated_field_synonyms = "CalculatedFieldSynonyms",
        .cell_value_synonyms = "CellValueSynonyms",
        .column_data_role = "ColumnDataRole",
        .comparative_order = "ComparativeOrder",
        .default_formatting = "DefaultFormatting",
        .disable_indexing = "DisableIndexing",
        .expression = "Expression",
        .is_included_in_topic = "IsIncludedInTopic",
        .never_aggregate_in_filter = "NeverAggregateInFilter",
        .non_additive = "NonAdditive",
        .not_allowed_aggregations = "NotAllowedAggregations",
        .semantic_type = "SemanticType",
        .time_granularity = "TimeGranularity",
    };
};
