pub const PricingRuleScope = enum {
    global,
    service,
    billing_entity,
    sku,

    pub const json_field_names = .{
        .global = "GLOBAL",
        .service = "SERVICE",
        .billing_entity = "BILLING_ENTITY",
        .sku = "SKU",
    };
};
