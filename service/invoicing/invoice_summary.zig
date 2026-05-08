const InvoiceCurrencyAmount = @import("invoice_currency_amount.zig").InvoiceCurrencyAmount;
const BillingPeriod = @import("billing_period.zig").BillingPeriod;
const BillType = @import("bill_type.zig").BillType;
const EinvoiceDeliveryStatus = @import("einvoice_delivery_status.zig").EinvoiceDeliveryStatus;
const Entity = @import("entity.zig").Entity;
const InvoiceFrequency = @import("invoice_frequency.zig").InvoiceFrequency;
const InvoiceType = @import("invoice_type.zig").InvoiceType;
const ReceiverRole = @import("receiver_role.zig").ReceiverRole;
const TaxAuthorityStatus = @import("tax_authority_status.zig").TaxAuthorityStatus;

/// The invoice that the API retrieved.
pub const InvoiceSummary = struct {
    /// The Amazon Web Services account ID.
    account_id: ?[]const u8 = null,

    /// The summary with the product and service currency.
    base_currency_amount: ?InvoiceCurrencyAmount = null,

    /// The billing period of the invoice-related document.
    billing_period: ?BillingPeriod = null,

    /// The list of Amazon Web Services account IDs that are the bill source of the
    /// invoice. Currently, only a single bill source account is returned.
    bill_source_accounts: ?[]const []const u8 = null,

    /// The total number of accounts that are the bill source of the invoice.
    bill_source_accounts_total_count: ?i32 = null,

    /// The type of the bill.
    bill_type: ?BillType = null,

    /// The commercial invoice ID. This is only applicable for tax invoices and
    /// identifies the associated commercial invoice.
    commercial_invoice_id: ?[]const u8 = null,

    /// The invoice due date.
    due_date: ?i64 = null,

    /// The e-invoice delivery status.
    einvoice_delivery_status: ?EinvoiceDeliveryStatus = null,

    /// The organization name providing Amazon Web Services services.
    entity: ?Entity = null,

    /// The frequency of the invoice.
    invoice_frequency: ?InvoiceFrequency = null,

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

    /// The role of the invoice receiver.
    receiver_role: ?ReceiverRole = null,

    /// The current status of an invoice as reported to the tax authority. This
    /// captures scenarios where an invoice may be cancelled after issuance.
    tax_authority_status: ?TaxAuthorityStatus = null,

    /// The summary with the tax currency.
    tax_currency_amount: ?InvoiceCurrencyAmount = null,

    pub const json_field_names = .{
        .account_id = "AccountId",
        .base_currency_amount = "BaseCurrencyAmount",
        .billing_period = "BillingPeriod",
        .bill_source_accounts = "BillSourceAccounts",
        .bill_source_accounts_total_count = "BillSourceAccountsTotalCount",
        .bill_type = "BillType",
        .commercial_invoice_id = "CommercialInvoiceId",
        .due_date = "DueDate",
        .einvoice_delivery_status = "EinvoiceDeliveryStatus",
        .entity = "Entity",
        .invoice_frequency = "InvoiceFrequency",
        .invoice_id = "InvoiceId",
        .invoice_type = "InvoiceType",
        .issued_date = "IssuedDate",
        .original_invoice_id = "OriginalInvoiceId",
        .payment_currency_amount = "PaymentCurrencyAmount",
        .purchase_order_number = "PurchaseOrderNumber",
        .receiver_role = "ReceiverRole",
        .tax_authority_status = "TaxAuthorityStatus",
        .tax_currency_amount = "TaxCurrencyAmount",
    };
};
