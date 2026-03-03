const AmountBreakdown = @import("amount_breakdown.zig").AmountBreakdown;
const CurrencyExchangeDetails = @import("currency_exchange_details.zig").CurrencyExchangeDetails;

/// The amount charged after taxes, in the preferred currency.
pub const InvoiceCurrencyAmount = struct {
    /// Details about the invoice currency amount.
    amount_breakdown: ?AmountBreakdown = null,

    /// The currency dominion of the invoice document.
    currency_code: ?[]const u8 = null,

    /// The details of currency exchange.
    currency_exchange_details: ?CurrencyExchangeDetails = null,

    /// The invoice currency amount.
    total_amount: ?[]const u8 = null,

    /// Details about the invoice total amount before tax.
    total_amount_before_tax: ?[]const u8 = null,

    pub const json_field_names = .{
        .amount_breakdown = "AmountBreakdown",
        .currency_code = "CurrencyCode",
        .currency_exchange_details = "CurrencyExchangeDetails",
        .total_amount = "TotalAmount",
        .total_amount_before_tax = "TotalAmountBeforeTax",
    };
};
