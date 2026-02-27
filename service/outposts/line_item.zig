const LineItemAssetInformation = @import("line_item_asset_information.zig").LineItemAssetInformation;
const ShipmentInformation = @import("shipment_information.zig").ShipmentInformation;
const LineItemStatus = @import("line_item_status.zig").LineItemStatus;

/// Information about a line item.
pub const LineItem = struct {
    /// Information about assets.
    asset_information_list: ?[]const LineItemAssetInformation,

    /// The ID of the catalog item.
    catalog_item_id: ?[]const u8,

    /// The ID of the line item.
    line_item_id: ?[]const u8,

    /// The ID of the previous line item.
    previous_line_item_id: ?[]const u8,

    /// The ID of the previous order.
    previous_order_id: ?[]const u8,

    /// The quantity of the line item.
    quantity: ?i32,

    /// Information about a line item shipment.
    shipment_information: ?ShipmentInformation,

    /// The status of the line item.
    status: ?LineItemStatus,

    pub const json_field_names = .{
        .asset_information_list = "AssetInformationList",
        .catalog_item_id = "CatalogItemId",
        .line_item_id = "LineItemId",
        .previous_line_item_id = "PreviousLineItemId",
        .previous_order_id = "PreviousOrderId",
        .quantity = "Quantity",
        .shipment_information = "ShipmentInformation",
        .status = "Status",
    };
};
