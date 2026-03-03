const aws = @import("aws");

/// The inventory result item.
pub const InventoryResultItem = struct {
    /// The time inventory item data was captured.
    capture_time: ?[]const u8 = null,

    /// Contains all the inventory data of the item type. Results include attribute
    /// names and
    /// values.
    content: []const []const aws.map.StringMapEntry,

    /// MD5 hash of the inventory item type contents. The content hash is used to
    /// determine whether
    /// to update inventory information. The PutInventory API doesn't update the
    /// inventory item type
    /// contents if the MD5 hash hasn't changed since last update.
    content_hash: ?[]const u8 = null,

    /// The schema version for the inventory result item/
    schema_version: []const u8,

    /// The name of the inventory result item type.
    type_name: []const u8,

    pub const json_field_names = .{
        .capture_time = "CaptureTime",
        .content = "Content",
        .content_hash = "ContentHash",
        .schema_version = "SchemaVersion",
        .type_name = "TypeName",
    };
};
