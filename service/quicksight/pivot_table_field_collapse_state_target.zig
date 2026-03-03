const DataPathValue = @import("data_path_value.zig").DataPathValue;

/// The target of a pivot table field collapse state.
pub const PivotTableFieldCollapseStateTarget = struct {
    /// The data path of the pivot table's header. Used to set the collapse state.
    field_data_path_values: ?[]const DataPathValue = null,

    /// The field ID of the pivot table that the collapse state needs to be set to.
    field_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .field_data_path_values = "FieldDataPathValues",
        .field_id = "FieldId",
    };
};
