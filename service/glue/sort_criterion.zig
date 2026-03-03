const Sort = @import("sort.zig").Sort;

/// Specifies a field to sort by and a sort order.
pub const SortCriterion = struct {
    /// The name of the field on which to sort.
    field_name: ?[]const u8 = null,

    /// An ascending or descending sort.
    sort: ?Sort = null,

    pub const json_field_names = .{
        .field_name = "FieldName",
        .sort = "Sort",
    };
};
