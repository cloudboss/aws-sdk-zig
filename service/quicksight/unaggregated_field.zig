const ColumnIdentifier = @import("column_identifier.zig").ColumnIdentifier;
const FormatConfiguration = @import("format_configuration.zig").FormatConfiguration;

/// The unaggregated field for a table.
pub const UnaggregatedField = struct {
    /// The column that is used in the `UnaggregatedField`.
    column: ColumnIdentifier,

    /// The custom field ID.
    field_id: []const u8,

    /// The format configuration of the field.
    format_configuration: ?FormatConfiguration,

    pub const json_field_names = .{
        .column = "Column",
        .field_id = "FieldId",
        .format_configuration = "FormatConfiguration",
    };
};
