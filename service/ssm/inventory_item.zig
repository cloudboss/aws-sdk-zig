const aws = @import("aws");

/// Information collected from managed nodes based on your inventory policy
/// document
pub const InventoryItem = struct {
    /// The time the inventory information was collected.
    capture_time: []const u8,

    /// The inventory data of the inventory type.
    content: ?[]const []const aws.map.StringMapEntry = null,

    /// MD5 hash of the inventory item type contents. The content hash is used to
    /// determine whether
    /// to update inventory information. The PutInventory API doesn't update the
    /// inventory item type
    /// contents if the MD5 hash hasn't changed since last update.
    content_hash: ?[]const u8 = null,

    /// A map of associated properties for a specified inventory type. For example,
    /// with this
    /// attribute, you can specify the `ExecutionId`, `ExecutionType`,
    /// `ComplianceType` properties of the `AWS:ComplianceItem` type.
    context: ?[]const aws.map.StringMapEntry = null,

    /// The schema version for the inventory item.
    schema_version: []const u8,

    /// The name of the inventory type. Default inventory item type names start with
    /// `AWS`. Custom inventory type names will start with Custom. Default inventory
    /// item
    /// types include the following: `AWS:AWSComponent`, `AWS:Application`,
    /// `AWS:InstanceInformation`, `AWS:Network`, and
    /// `AWS:WindowsUpdate`.
    type_name: []const u8,

    pub const json_field_names = .{
        .capture_time = "CaptureTime",
        .content = "Content",
        .content_hash = "ContentHash",
        .context = "Context",
        .schema_version = "SchemaVersion",
        .type_name = "TypeName",
    };
};
