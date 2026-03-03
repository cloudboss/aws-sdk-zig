const MonetaryAmount = @import("monetary_amount.zig").MonetaryAmount;
const OfferingStatus = @import("offering_status.zig").OfferingStatus;

/// Represents the metadata of an offering transaction.
pub const OfferingTransaction = struct {
    /// The cost of an offering transaction.
    cost: ?MonetaryAmount = null,

    /// The date on which an offering transaction was created.
    created_on: ?i64 = null,

    /// The ID that corresponds to a device offering promotion.
    offering_promotion_id: ?[]const u8 = null,

    /// The status of an offering transaction.
    offering_status: ?OfferingStatus = null,

    /// The transaction ID of the offering transaction.
    transaction_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .cost = "cost",
        .created_on = "createdOn",
        .offering_promotion_id = "offeringPromotionId",
        .offering_status = "offeringStatus",
        .transaction_id = "transactionId",
    };
};
