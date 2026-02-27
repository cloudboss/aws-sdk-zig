const SortDirection = @import("sort_direction.zig").SortDirection;

/// Describes how to sort the data that you bind to a component.
pub const SortProperty = struct {
    /// The direction of the sort, either ascending or descending.
    direction: SortDirection,

    /// The field to perform the sort on.
    field: []const u8,

    pub const json_field_names = .{
        .direction = "direction",
        .field = "field",
    };
};
