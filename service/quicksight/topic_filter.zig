const TopicCategoryFilter = @import("topic_category_filter.zig").TopicCategoryFilter;
const TopicDateRangeFilter = @import("topic_date_range_filter.zig").TopicDateRangeFilter;
const FilterClass = @import("filter_class.zig").FilterClass;
const NamedFilterType = @import("named_filter_type.zig").NamedFilterType;
const TopicNullFilter = @import("topic_null_filter.zig").TopicNullFilter;
const TopicNumericEqualityFilter = @import("topic_numeric_equality_filter.zig").TopicNumericEqualityFilter;
const TopicNumericRangeFilter = @import("topic_numeric_range_filter.zig").TopicNumericRangeFilter;
const TopicRelativeDateFilter = @import("topic_relative_date_filter.zig").TopicRelativeDateFilter;

/// A structure that represents a filter used to select items for a topic.
pub const TopicFilter = struct {
    /// The category filter that is associated with this filter.
    category_filter: ?TopicCategoryFilter = null,

    /// The date range filter.
    date_range_filter: ?TopicDateRangeFilter = null,

    /// The class of the filter. Valid values for this structure are
    /// `ENFORCED_VALUE_FILTER`,
    /// `CONDITIONAL_VALUE_FILTER`,
    /// and `NAMED_VALUE_FILTER`.
    filter_class: ?FilterClass = null,

    /// A description of the filter used to select items for a topic.
    filter_description: ?[]const u8 = null,

    /// The name of the filter.
    filter_name: []const u8,

    /// The other names or aliases for the filter.
    filter_synonyms: ?[]const []const u8 = null,

    /// The type of the filter. Valid values for this structure are
    /// `CATEGORY_FILTER`, `NUMERIC_EQUALITY_FILTER`,
    /// `NUMERIC_RANGE_FILTER`,
    /// `DATE_RANGE_FILTER`,
    /// and `RELATIVE_DATE_FILTER`.
    filter_type: ?NamedFilterType = null,

    /// The null filter.
    null_filter: ?TopicNullFilter = null,

    /// The numeric equality filter.
    numeric_equality_filter: ?TopicNumericEqualityFilter = null,

    /// The numeric range filter.
    numeric_range_filter: ?TopicNumericRangeFilter = null,

    /// The name of the field that the filter operates on.
    operand_field_name: []const u8,

    /// The relative date filter.
    relative_date_filter: ?TopicRelativeDateFilter = null,

    pub const json_field_names = .{
        .category_filter = "CategoryFilter",
        .date_range_filter = "DateRangeFilter",
        .filter_class = "FilterClass",
        .filter_description = "FilterDescription",
        .filter_name = "FilterName",
        .filter_synonyms = "FilterSynonyms",
        .filter_type = "FilterType",
        .null_filter = "NullFilter",
        .numeric_equality_filter = "NumericEqualityFilter",
        .numeric_range_filter = "NumericRangeFilter",
        .operand_field_name = "OperandFieldName",
        .relative_date_filter = "RelativeDateFilter",
    };
};
