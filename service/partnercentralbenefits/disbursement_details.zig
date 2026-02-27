const MonetaryValue = @import("monetary_value.zig").MonetaryValue;
const IssuanceDetail = @import("issuance_detail.zig").IssuanceDetail;

/// Contains information about disbursement-based benefit fulfillment, such as
/// direct payments or reimbursements.
pub const DisbursementDetails = struct {
    /// The total amount that has been disbursed for this benefit allocation.
    disbursed_amount: ?MonetaryValue,

    /// Detailed information about how the disbursement was issued and processed.
    issuance_details: ?IssuanceDetail,

    pub const json_field_names = .{
        .disbursed_amount = "DisbursedAmount",
        .issuance_details = "IssuanceDetails",
    };
};
