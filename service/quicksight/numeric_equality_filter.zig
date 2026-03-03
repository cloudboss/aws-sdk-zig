const AggregationFunction = @import("aggregation_function.zig").AggregationFunction;
const ColumnIdentifier = @import("column_identifier.zig").ColumnIdentifier;
const DefaultFilterControlConfiguration = @import("default_filter_control_configuration.zig").DefaultFilterControlConfiguration;
const NumericEqualityMatchOperator = @import("numeric_equality_match_operator.zig").NumericEqualityMatchOperator;
const FilterNullOption = @import("filter_null_option.zig").FilterNullOption;
const NumericFilterSelectAllOptions = @import("numeric_filter_select_all_options.zig").NumericFilterSelectAllOptions;

/// A `NumericEqualityFilter` filters values that are equal to the specified
/// value.
pub const NumericEqualityFilter = struct {
    /// The aggregation function of the filter.
    aggregation_function: ?AggregationFunction = null,

    /// The column that the filter is applied to.
    column: ColumnIdentifier,

    /// The default configurations for the associated controls. This applies only
    /// for filters that are scoped to multiple sheets.
    default_filter_control_configuration: ?DefaultFilterControlConfiguration = null,

    /// An identifier that uniquely identifies a filter within a dashboard,
    /// analysis, or template.
    filter_id: []const u8,

    /// The match operator that is used to determine if a filter should be applied.
    match_operator: NumericEqualityMatchOperator,

    /// This option determines how null values should be treated when filtering
    /// data.
    ///
    /// * `ALL_VALUES`: Include null values in filtered results.
    ///
    /// * `NULLS_ONLY`: Only include null values in filtered results.
    ///
    /// * `NON_NULLS_ONLY`: Exclude null values from filtered results.
    null_option: FilterNullOption,

    /// The parameter whose value should be used for the filter value.
    parameter_name: ?[]const u8 = null,

    /// Select all of the values. Null is not the assigned value of select all.
    ///
    /// * `FILTER_ALL_VALUES`
    select_all_options: ?NumericFilterSelectAllOptions = null,

    /// The input value.
    value: ?f64 = null,

    pub const json_field_names = .{
        .aggregation_function = "AggregationFunction",
        .column = "Column",
        .default_filter_control_configuration = "DefaultFilterControlConfiguration",
        .filter_id = "FilterId",
        .match_operator = "MatchOperator",
        .null_option = "NullOption",
        .parameter_name = "ParameterName",
        .select_all_options = "SelectAllOptions",
        .value = "Value",
    };
};
