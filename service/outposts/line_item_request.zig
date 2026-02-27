/// Information about a line item request.
pub const LineItemRequest = struct {
    /// The ID of the catalog item.
    catalog_item_id: ?[]const u8,

    /// The quantity of a line item request.
    quantity: ?i32,

    pub const json_field_names = .{
        .catalog_item_id = "CatalogItemId",
        .quantity = "Quantity",
    };
};
