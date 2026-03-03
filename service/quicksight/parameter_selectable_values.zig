const ColumnIdentifier = @import("column_identifier.zig").ColumnIdentifier;

/// A list of selectable values that are used in a control.
pub const ParameterSelectableValues = struct {
    /// The column identifier that fetches values from the data set.
    link_to_data_set_column: ?ColumnIdentifier = null,

    /// The values that are used in `ParameterSelectableValues`.
    values: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .link_to_data_set_column = "LinkToDataSetColumn",
        .values = "Values",
    };
};
