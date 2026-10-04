const Amount = @import("amount.zig").Amount;

/// A single entry in the credit allocation history, representing how a credit
/// was applied to a specific service during a billing month.
pub const CreditAllocationHistoryEntry = struct {
    /// The Amazon Web Services account the credit was applied to.
    account_id: []const u8,

    /// The Amazon Web Services service the credit was applied to.
    applied_service_name: []const u8,

    /// The billing month of the application in `YYYY-MM` format.
    billing_month: []const u8,

    /// The amount of credit applied. Negative values represent credits that reduced
    /// the bill.
    credit_amount: Amount,

    /// The identifier of the credit that was applied.
    credit_id: []const u8,

    /// A human-readable description of the credit allocation.
    description: ?[]const u8 = null,

    /// `true` when the entry was applied to an in-flight bill that has not yet been
    /// finalized.
    is_estimated_bill: bool,

    pub const json_field_names = .{
        .account_id = "accountId",
        .applied_service_name = "appliedServiceName",
        .billing_month = "billingMonth",
        .credit_amount = "creditAmount",
        .credit_id = "creditId",
        .description = "description",
        .is_estimated_bill = "isEstimatedBill",
    };
};
