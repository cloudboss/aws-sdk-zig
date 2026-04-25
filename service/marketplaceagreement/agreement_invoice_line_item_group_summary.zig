const InvoiceBillingPeriod = @import("invoice_billing_period.zig").InvoiceBillingPeriod;
const InvoiceType = @import("invoice_type.zig").InvoiceType;
const InvoicingEntity = @import("invoicing_entity.zig").InvoicingEntity;
const PricingCurrencyAmount = @import("pricing_currency_amount.zig").PricingCurrencyAmount;

/// A summary of grouped billing data for an agreement invoice line item.
pub const AgreementInvoiceLineItemGroupSummary = struct {
    /// The unique identifier of the agreement.
    agreement_id: ?[]const u8 = null,

    /// The billing period associated with this group.
    invoice_billing_period: ?InvoiceBillingPeriod = null,

    /// The identifier of the invoice for this group.
    invoice_id: ?[]const u8 = null,

    /// The type of invoice. Valid values are `INVOICE` and `CREDIT_MEMO`.
    invoice_type: ?InvoiceType = null,

    /// The entity that issues the invoice.
    invoicing_entity: ?InvoicingEntity = null,

    /// The timestamp when the invoice containing this group was created.
    issued_time: ?i64 = null,

    /// Monetary amounts for this invoice group.
    pricing_currency_amount: ?PricingCurrencyAmount = null,

    pub const json_field_names = .{
        .agreement_id = "agreementId",
        .invoice_billing_period = "invoiceBillingPeriod",
        .invoice_id = "invoiceId",
        .invoice_type = "invoiceType",
        .invoicing_entity = "invoicingEntity",
        .issued_time = "issuedTime",
        .pricing_currency_amount = "pricingCurrencyAmount",
    };
};
