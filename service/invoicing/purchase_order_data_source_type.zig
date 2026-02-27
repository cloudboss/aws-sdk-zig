pub const PurchaseOrderDataSourceType = enum {
    associated_purchase_order_required,
    purchase_order_not_required,

    pub const json_field_names = .{
        .associated_purchase_order_required = "ASSOCIATED_PURCHASE_ORDER_REQUIRED",
        .purchase_order_not_required = "PURCHASE_ORDER_NOT_REQUIRED",
    };
};
