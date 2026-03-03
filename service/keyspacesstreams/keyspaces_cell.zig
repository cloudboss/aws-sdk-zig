const KeyspacesMetadata = @import("keyspaces_metadata.zig").KeyspacesMetadata;
const KeyspacesCellValue = @import("keyspaces_cell_value.zig").KeyspacesCellValue;

/// Represents a cell in an Amazon Keyspaces table, containing both the value
/// and metadata about the cell.
pub const KeyspacesCell = struct {
    /// Metadata associated with this cell, such as time-to-live (TTL) expiration
    /// time and write timestamp.
    metadata: ?KeyspacesMetadata = null,

    /// The value stored in this cell, which can be of various data types supported
    /// by Amazon Keyspaces.
    value: ?KeyspacesCellValue = null,

    pub const json_field_names = .{
        .metadata = "metadata",
        .value = "value",
    };
};
