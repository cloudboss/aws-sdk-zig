const UnaggregatedField = @import("unaggregated_field.zig").UnaggregatedField;

/// The unaggregated field well for the table.
pub const TableUnaggregatedFieldWells = struct {
    /// The values field well for a pivot table. Values are unaggregated for an
    /// unaggregated table.
    values: ?[]const UnaggregatedField = null,

    pub const json_field_names = .{
        .values = "Values",
    };
};
