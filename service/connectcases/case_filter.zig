const FieldFilter = @import("field_filter.zig").FieldFilter;
const TagFilter = @import("tag_filter.zig").TagFilter;

/// A filter for cases. Only one value can be provided.
pub const CaseFilter = union(enum) {
    /// Provides "and all" filtering.
    and_all: ?[]const CaseFilter,
    /// A list of fields to filter on.
    field: ?FieldFilter,
    not: ?CaseFilter,
    /// Provides "or all" filtering.
    or_all: ?[]const CaseFilter,
    /// A list of tags to filter on.
    tag: ?TagFilter,

    pub const json_field_names = .{
        .and_all = "andAll",
        .field = "field",
        .not = "not",
        .or_all = "orAll",
        .tag = "tag",
    };
};
