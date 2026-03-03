const ColumnIdentifier = @import("column_identifier.zig").ColumnIdentifier;
const NumberFormatConfiguration = @import("number_format_configuration.zig").NumberFormatConfiguration;

/// The dimension type field with numerical type columns.
pub const NumericalDimensionField = struct {
    /// The column that is used in the `NumericalDimensionField`.
    column: ColumnIdentifier,

    /// The custom field ID.
    field_id: []const u8,

    /// The format configuration of the field.
    format_configuration: ?NumberFormatConfiguration = null,

    /// The custom hierarchy ID.
    hierarchy_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .column = "Column",
        .field_id = "FieldId",
        .format_configuration = "FormatConfiguration",
        .hierarchy_id = "HierarchyId",
    };
};
