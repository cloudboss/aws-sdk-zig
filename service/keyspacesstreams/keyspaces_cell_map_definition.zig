const KeyspacesCellValue = @import("keyspaces_cell_value.zig").KeyspacesCellValue;
const KeyspacesMetadata = @import("keyspaces_metadata.zig").KeyspacesMetadata;

/// Represents a key-value pair within a map data type in Amazon Keyspaces,
/// including the associated metadata.
pub const KeyspacesCellMapDefinition = struct {
    /// The key of this map entry in the Amazon Keyspaces cell.
    key: ?KeyspacesCellValue,

    /// Metadata for this specific key-value pair within the map, such as timestamps
    /// and TTL information.
    metadata: ?KeyspacesMetadata,

    /// The value associated with the key in this map entry.
    value: ?KeyspacesCellValue,

    pub const json_field_names = .{
        .key = "key",
        .metadata = "metadata",
        .value = "value",
    };
};
