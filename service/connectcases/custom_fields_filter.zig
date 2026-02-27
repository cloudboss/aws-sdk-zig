const FieldFilter = @import("field_filter.zig").FieldFilter;

/// A filter for fields in `Custom` type related items. Only one value can be
/// provided.
pub const CustomFieldsFilter = union(enum) {
    /// Provides "and all" filtering.
    and_all: ?[]const CustomFieldsFilter,
    field: ?FieldFilter,
    /// Excludes items matching the filter.
    not: ?CustomFieldsFilter,
    /// Provides "or all" filtering.
    or_all: ?[]const CustomFieldsFilter,

    pub const json_field_names = .{
        .and_all = "andAll",
        .field = "field",
        .not = "not",
        .or_all = "orAll",
    };
};
