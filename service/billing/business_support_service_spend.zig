/// A service-level spend entry contributing to Business Support eligible spend.
pub const BusinessSupportServiceSpend = struct {
    /// The Support-eligible spend amount for this service.
    charge_amount: []const u8,

    /// The name of the Amazon Web Services service contributing to the
    /// Support-eligible spend.
    contributing_service: []const u8,

    /// The ISO 4217 currency code for the charge amount (for example, `USD`).
    currency: []const u8,

    /// A human-readable description of the service spend entry.
    description: ?[]const u8 = null,

    /// The type of the line item. Valid values: `Usage`.
    item_type: []const u8,

    pub const json_field_names = .{
        .charge_amount = "chargeAmount",
        .contributing_service = "contributingService",
        .currency = "currency",
        .description = "description",
        .item_type = "itemType",
    };
};
