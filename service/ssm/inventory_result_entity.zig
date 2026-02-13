const aws = @import("aws");

const InventoryResultItem = @import("inventory_result_item.zig").InventoryResultItem;

/// Inventory query results.
pub const InventoryResultEntity = struct {
    /// The data section in the inventory result entity JSON.
    data: ?[]const aws.map.MapEntry(InventoryResultItem),

    /// ID of the inventory result entity. For example, for managed node inventory
    /// the result will
    /// be the managed node ID. For EC2 instance inventory, the result will be the
    /// instance ID.
    id: ?[]const u8,

    pub const json_field_names = .{
        .data = "Data",
        .id = "Id",
    };
};
