/// Contains information about a purchase order association to a charge within
/// an agreement.
pub const PurchaseOrder = struct {
    /// The unique identifier of the agreement associated with this charge.
    agreement_id: ?[]const u8 = null,

    /// The unique identifier of the charge to associate the purchase order with.
    charge_id: []const u8,

    /// The revision of the charge.
    charge_revision: ?i64 = null,

    /// The purchase order reference to associate with the charge.
    purchase_order_reference: ?[]const u8 = null,

    pub const json_field_names = .{
        .agreement_id = "agreementId",
        .charge_id = "chargeId",
        .charge_revision = "chargeRevision",
        .purchase_order_reference = "purchaseOrderReference",
    };
};
