const CategoryFilterMatchOperator = @import("category_filter_match_operator.zig").CategoryFilterMatchOperator;
const FilterNullOption = @import("filter_null_option.zig").FilterNullOption;
const CategoryFilterSelectAllOptions = @import("category_filter_select_all_options.zig").CategoryFilterSelectAllOptions;

/// A custom filter that filters based on a single value. This filter can be
/// partially matched.
pub const CustomFilterConfiguration = struct {
    /// The category value for the filter.
    ///
    /// This field is mutually exclusive to `ParameterName`.
    category_value: ?[]const u8,

    /// The match operator that is used to determine if a filter should be applied.
    match_operator: CategoryFilterMatchOperator,

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
    ///
    /// This field is mutually exclusive to `CategoryValue`.
    parameter_name: ?[]const u8,

    /// Select all of the values. Null is not the assigned value of select all.
    ///
    /// * `FILTER_ALL_VALUES`
    select_all_options: ?CategoryFilterSelectAllOptions,

    pub const json_field_names = .{
        .category_value = "CategoryValue",
        .match_operator = "MatchOperator",
        .null_option = "NullOption",
        .parameter_name = "ParameterName",
        .select_all_options = "SelectAllOptions",
    };
};
