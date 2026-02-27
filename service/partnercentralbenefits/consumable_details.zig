const MonetaryValue = @import("monetary_value.zig").MonetaryValue;
const IssuanceDetail = @import("issuance_detail.zig").IssuanceDetail;

/// Contains information about consumable benefit fulfillment, such as usage
/// quotas or service limits.
pub const ConsumableDetails = struct {
    /// The total amount of the consumable benefit that has been allocated.
    allocated_amount: ?MonetaryValue,

    /// Detailed information about how the consumable benefit was issued and
    /// distributed.
    issuance_details: ?IssuanceDetail,

    /// The remaining amount of the consumable benefit that is still available for
    /// use.
    remaining_amount: ?MonetaryValue,

    /// The amount of the consumable benefit that has already been used.
    utilized_amount: ?MonetaryValue,

    pub const json_field_names = .{
        .allocated_amount = "AllocatedAmount",
        .issuance_details = "IssuanceDetails",
        .remaining_amount = "RemainingAmount",
        .utilized_amount = "UtilizedAmount",
    };
};
