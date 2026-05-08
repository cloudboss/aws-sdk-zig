/// Represents a charge associated with an agreement, including amount, timing,
/// and purchase order details.
pub const Charge = struct {
    /// The unique identifier of the agreement that resulted in this charge.
    agreement_id: ?[]const u8 = null,

    /// The type of agreement that resulted in this charge (for example,
    /// `PurchaseAgreement`).
    agreement_type: ?[]const u8 = null,

    /// The amount of the charge.
    amount: ?[]const u8 = null,

    /// The currency code for the charge amount.
    currency_code: ?[]const u8 = null,

    /// The unique identifier of the charge.
    id: ?[]const u8 = null,

    /// The purchase order reference associated with the charge, if any.
    purchase_order_reference: ?[]const u8 = null,

    /// The revision number of the charge.
    revision: ?i64 = null,

    /// The date and time when the charge will be incurred. This is available only
    /// when the charge date is known.
    time: ?i64 = null,

    pub const json_field_names = .{
        .agreement_id = "agreementId",
        .agreement_type = "agreementType",
        .amount = "amount",
        .currency_code = "currencyCode",
        .id = "id",
        .purchase_order_reference = "purchaseOrderReference",
        .revision = "revision",
        .time = "time",
    };
};
