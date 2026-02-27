pub const PurchaseMode = enum {
    manual,
    auto_purchase,

    pub const json_field_names = .{
        .manual = "MANUAL",
        .auto_purchase = "AUTO_PURCHASE",
    };
};
