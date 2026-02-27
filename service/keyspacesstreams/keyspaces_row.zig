const aws = @import("aws");

const KeyspacesMetadata = @import("keyspaces_metadata.zig").KeyspacesMetadata;
const KeyspacesCell = @import("keyspaces_cell.zig").KeyspacesCell;

/// Represents a row in an Amazon Keyspaces table, containing regular column
/// values, static column values, and row-level metadata.
pub const KeyspacesRow = struct {
    /// Metadata that applies to the entire row, such as timestamps and TTL
    /// information.
    row_metadata: ?KeyspacesMetadata,

    /// A map of static column cells shared by all rows with the same partition key,
    /// where keys are column names and values are the corresponding cells.
    static_cells: ?[]const aws.map.MapEntry(KeyspacesCell),

    /// A map of regular (non-static) column cells in the row, where keys are column
    /// names and values are the corresponding cells.
    value_cells: ?[]const aws.map.MapEntry(KeyspacesCell),

    pub const json_field_names = .{
        .row_metadata = "rowMetadata",
        .static_cells = "staticCells",
        .value_cells = "valueCells",
    };
};
