const InventoryAttributeDataType = @import("inventory_attribute_data_type.zig").InventoryAttributeDataType;

/// Attributes are the entries within the inventory item content. It contains
/// name and
/// value.
pub const InventoryItemAttribute = struct {
    /// The data type of the inventory item attribute.
    data_type: InventoryAttributeDataType,

    /// Name of the inventory item attribute.
    name: []const u8,

    pub const json_field_names = .{
        .data_type = "DataType",
        .name = "Name",
    };
};
