const CostAmount = @import("cost_amount.zig").CostAmount;
const PurchaseAgreementType = @import("purchase_agreement_type.zig").PurchaseAgreementType;

/// Provides a summary of commitment-related information for a bill estimate.
pub const BillEstimateCommitmentSummary = struct {
    /// The unique identifier of the commitment.
    id: ?[]const u8,

    /// The monthly payment amount for this commitment, if applicable.
    monthly_payment: ?CostAmount,

    /// The identifier of the specific offering associated with this commitment.
    offering_id: ?[]const u8,

    /// The payment option chosen for this commitment (e.g., All Upfront, Partial
    /// Upfront, No Upfront).
    payment_option: ?[]const u8,

    /// The type of purchase agreement (e.g., Reserved Instance, Savings Plan).
    purchase_agreement_type: ?PurchaseAgreementType,

    /// The Amazon Web Services region associated with this commitment.
    region: ?[]const u8,

    /// The length of the commitment term.
    term_length: ?[]const u8,

    /// The upfront payment amount for this commitment, if applicable.
    upfront_payment: ?CostAmount,

    /// The Amazon Web Services account ID associated with this commitment.
    usage_account_id: ?[]const u8,

    pub const json_field_names = .{
        .id = "id",
        .monthly_payment = "monthlyPayment",
        .offering_id = "offeringId",
        .payment_option = "paymentOption",
        .purchase_agreement_type = "purchaseAgreementType",
        .region = "region",
        .term_length = "termLength",
        .upfront_payment = "upfrontPayment",
        .usage_account_id = "usageAccountId",
    };
};
