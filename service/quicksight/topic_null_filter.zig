const TopicSingularFilterConstant = @import("topic_singular_filter_constant.zig").TopicSingularFilterConstant;
const NullFilterType = @import("null_filter_type.zig").NullFilterType;

/// The structure that represents a null filter.
pub const TopicNullFilter = struct {
    constant: ?TopicSingularFilterConstant,

    /// A Boolean value that indicates if the filter is inverse.
    inverse: bool = false,

    /// The type of the null filter. Valid values for this type are `NULLS_ONLY`,
    /// `NON_NULLS_ONLY`, and `ALL_VALUES`.
    null_filter_type: ?NullFilterType,

    pub const json_field_names = .{
        .constant = "Constant",
        .inverse = "Inverse",
        .null_filter_type = "NullFilterType",
    };
};
