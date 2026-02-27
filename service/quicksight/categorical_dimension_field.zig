const ColumnIdentifier = @import("column_identifier.zig").ColumnIdentifier;
const StringFormatConfiguration = @import("string_format_configuration.zig").StringFormatConfiguration;

/// The dimension type field with categorical type columns..
pub const CategoricalDimensionField = struct {
    /// The column that is used in the `CategoricalDimensionField`.
    column: ColumnIdentifier,

    /// The custom field ID.
    field_id: []const u8,

    /// The format configuration of the field.
    format_configuration: ?StringFormatConfiguration,

    /// The custom hierarchy ID.
    hierarchy_id: ?[]const u8,

    pub const json_field_names = .{
        .column = "Column",
        .field_id = "FieldId",
        .format_configuration = "FormatConfiguration",
        .hierarchy_id = "HierarchyId",
    };
};
