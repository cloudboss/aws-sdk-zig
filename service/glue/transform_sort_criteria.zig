const TransformSortColumnType = @import("transform_sort_column_type.zig").TransformSortColumnType;
const SortDirectionType = @import("sort_direction_type.zig").SortDirectionType;

/// The sorting criteria that are associated with the machine learning
/// transform.
pub const TransformSortCriteria = struct {
    /// The column to be used in the sorting criteria that are associated with the
    /// machine
    /// learning transform.
    column: TransformSortColumnType,

    /// The sort direction to be used in the sorting criteria that are associated
    /// with the machine
    /// learning transform.
    sort_direction: SortDirectionType,

    pub const json_field_names = .{
        .column = "Column",
        .sort_direction = "SortDirection",
    };
};
