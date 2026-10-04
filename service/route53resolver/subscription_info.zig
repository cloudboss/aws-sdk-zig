/// Identifies the Amazon Web Services Marketplace product that backs a
/// partner-managed rule type. Returned as part of FirewallRuleTypeDefinition
/// when the rule type variant requires an active customer subscription to the
/// named product.
pub const SubscriptionInfo = struct {
    /// The Amazon Web Services Marketplace product identifier of the partner
    /// threat-protection product. Use this value to verify or manage the calling
    /// account's subscription in Amazon Web Services Marketplace.
    product_id: ?[]const u8 = null,

    /// The name of the Amazon Web Services Marketplace seller (vendor) that
    /// publishes the partner threat-protection product (for example, `Palo Alto
    /// Networks`).
    vendor_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .product_id = "ProductId",
        .vendor_name = "VendorName",
    };
};
