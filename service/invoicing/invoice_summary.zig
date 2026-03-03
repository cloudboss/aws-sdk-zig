const InvoiceCurrencyAmount = @import("invoice_currency_amount.zig").InvoiceCurrencyAmount;
const BillingPeriod = @import("billing_period.zig").BillingPeriod;
const Entity = @import("entity.zig").Entity;
const InvoiceType = @import("invoice_type.zig").InvoiceType;

/// The invoice that the API retrieved.
pub const InvoiceSummary = struct {
    /// The Amazon Web Services account ID.
    account_id: ?[]const u8 = null,

    /// The summary with the product and service currency.
    base_currency_amount: ?InvoiceCurrencyAmount = null,

    /// The billing period of the invoice-related document.
    billing_period: ?BillingPeriod = null,

    /// The invoice due date.
    due_date: ?i64 = null,

    /// The organization name providing Amazon Web Services services.
    entity: ?Entity = null,

    /// The invoice ID.
    invoice_id: ?[]const u8 = null,

    /// The type of invoice.
    invoice_type: ?InvoiceType = null,

    /// The issued date of the invoice.
    issued_date: ?i64 = null,

    /// The initial or original invoice ID.
    original_invoice_id: ?[]const u8 = null,

    /// The summary with the customer configured currency.
    payment_currency_amount: ?InvoiceCurrencyAmount = null,

    /// The purchase order number associated to the invoice.
    purchase_order_number: ?[]const u8 = null,

    /// The summary with the tax currency.
    tax_currency_amount: ?InvoiceCurrencyAmount = null,

    pub const json_field_names = .{
        .account_id = "AccountId",
        .base_currency_amount = "BaseCurrencyAmount",
        .billing_period = "BillingPeriod",
        .due_date = "DueDate",
        .entity = "Entity",
        .invoice_id = "InvoiceId",
        .invoice_type = "InvoiceType",
        .issued_date = "IssuedDate",
        .original_invoice_id = "OriginalInvoiceId",
        .payment_currency_amount = "PaymentCurrencyAmount",
        .purchase_order_number = "PurchaseOrderNumber",
        .tax_currency_amount = "TaxCurrencyAmount",
    };
};
