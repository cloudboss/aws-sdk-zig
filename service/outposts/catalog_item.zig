const EC2Capacity = @import("ec2_capacity.zig").EC2Capacity;
const CatalogItemStatus = @import("catalog_item_status.zig").CatalogItemStatus;
const SupportedStorageEnum = @import("supported_storage_enum.zig").SupportedStorageEnum;

/// Information about a catalog item.
pub const CatalogItem = struct {
    /// The ID of the catalog item.
    catalog_item_id: ?[]const u8 = null,

    /// Information about the EC2 capacity of an item.
    ec2_capacities: ?[]const EC2Capacity = null,

    /// The status of a catalog item.
    item_status: ?CatalogItemStatus = null,

    /// Information about the power draw of an item.
    power_kva: ?f32 = null,

    /// The supported storage options for the catalog item.
    supported_storage: ?[]const SupportedStorageEnum = null,

    /// The uplink speed this catalog item requires for the connection to the
    /// Region.
    supported_uplink_gbps: ?[]const i32 = null,

    /// The weight of the item in pounds.
    weight_lbs: ?i32 = null,

    pub const json_field_names = .{
        .catalog_item_id = "CatalogItemId",
        .ec2_capacities = "EC2Capacities",
        .item_status = "ItemStatus",
        .power_kva = "PowerKva",
        .supported_storage = "SupportedStorage",
        .supported_uplink_gbps = "SupportedUplinkGbps",
        .weight_lbs = "WeightLbs",
    };
};
