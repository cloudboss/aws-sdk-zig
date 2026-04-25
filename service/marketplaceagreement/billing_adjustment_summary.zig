const BillingAdjustmentStatus = @import("billing_adjustment_status.zig").BillingAdjustmentStatus;

/// Summary view of a billing adjustment request.
pub const BillingAdjustmentSummary = struct {
    /// The adjustment amount as a string representation of a decimal number.
    adjustment_amount: []const u8,

    /// The unique identifier of the agreement associated with this billing
    /// adjustment request.
    agreement_id: []const u8,

    /// The type of agreement.
    agreement_type: []const u8,

    /// The unique identifier of the billing adjustment request.
    billing_adjustment_request_id: []const u8,

    /// The catalog in which the agreement was created.
    catalog: []const u8,

    /// The date and time when the billing adjustment request was created, as a
    /// POSIX timestamp (Unix epoch seconds).
    created_at: i64,

    /// The currency code for the adjustment amount.
    currency_code: []const u8,

    /// The identifier of the original invoice being adjusted.
    original_invoice_id: []const u8,

    /// The current status of the billing adjustment request.
    status: BillingAdjustmentStatus,

    /// The date and time when the billing adjustment request was last updated, as a
    /// POSIX timestamp (Unix epoch seconds).
    updated_at: i64,

    pub const json_field_names = .{
        .adjustment_amount = "adjustmentAmount",
        .agreement_id = "agreementId",
        .agreement_type = "agreementType",
        .billing_adjustment_request_id = "billingAdjustmentRequestId",
        .catalog = "catalog",
        .created_at = "createdAt",
        .currency_code = "currencyCode",
        .original_invoice_id = "originalInvoiceId",
        .status = "status",
        .updated_at = "updatedAt",
    };
};
