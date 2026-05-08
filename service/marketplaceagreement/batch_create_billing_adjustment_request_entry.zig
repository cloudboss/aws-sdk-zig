const BillingAdjustmentReasonCode = @import("billing_adjustment_reason_code.zig").BillingAdjustmentReasonCode;

/// An individual entry in a batch billing adjustment request, specifying the
/// invoice and adjustment details.
pub const BatchCreateBillingAdjustmentRequestEntry = struct {
    /// The adjustment amount as a string representation of a decimal number in the
    /// currency of the invoice.
    adjustment_amount: []const u8,

    /// The reason code for the billing adjustment.
    adjustment_reason_code: BillingAdjustmentReasonCode,

    /// The unique identifier of the agreement associated with the invoice.
    agreement_id: []const u8,

    /// A unique, case-sensitive identifier that you provide to ensure the
    /// idempotency of the request.
    client_token: []const u8,

    /// The 3-letter ISO 4217 currency code for the adjustment amount. Must match
    /// the currency code of the offer associated with the agreement (e.g., `USD`).
    currency_code: []const u8,

    /// An optional detailed description of the adjustment reason.
    description: ?[]const u8 = null,

    /// The identifier of the original invoice to adjust.
    original_invoice_id: []const u8,

    pub const json_field_names = .{
        .adjustment_amount = "adjustmentAmount",
        .adjustment_reason_code = "adjustmentReasonCode",
        .agreement_id = "agreementId",
        .client_token = "clientToken",
        .currency_code = "currencyCode",
        .description = "description",
        .original_invoice_id = "originalInvoiceId",
    };
};
