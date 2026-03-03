const InventoryItemAttribute = @import("inventory_item_attribute.zig").InventoryItemAttribute;

/// The inventory item schema definition. Users can use this to compose
/// inventory query
/// filters.
pub const InventoryItemSchema = struct {
    /// The schema attributes for inventory. This contains data type and attribute
    /// name.
    attributes: []const InventoryItemAttribute,

    /// The alias name of the inventory type. The alias name is used for display
    /// purposes.
    display_name: ?[]const u8 = null,

    /// The name of the inventory type. Default inventory item type names start with
    /// Amazon Web Services. Custom
    /// inventory type names will start with Custom. Default inventory item types
    /// include the following:
    /// `AWS:AWSComponent`, `AWS:Application`,
    /// `AWS:InstanceInformation`, `AWS:Network`, and
    /// `AWS:WindowsUpdate`.
    type_name: []const u8,

    /// The schema version for the inventory item.
    version: ?[]const u8 = null,

    pub const json_field_names = .{
        .attributes = "Attributes",
        .display_name = "DisplayName",
        .type_name = "TypeName",
        .version = "Version",
    };
};
