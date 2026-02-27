const SortDirection = @import("sort_direction.zig").SortDirection;

/// The sort configuration for a field in a
/// field well.
pub const FieldSort = struct {
    /// The sort direction. Choose one of the following
    /// options:
    ///
    /// * `ASC`: Ascending
    ///
    /// * `DESC`: Descending
    direction: SortDirection,

    /// The sort configuration target field.
    field_id: []const u8,

    pub const json_field_names = .{
        .direction = "Direction",
        .field_id = "FieldId",
    };
};
