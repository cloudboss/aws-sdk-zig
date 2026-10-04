const QuoteOption = @import("quote_option.zig").QuoteOption;
const QuoteStatus = @import("quote_status.zig").QuoteStatus;
const QuoteCapacity = @import("quote_capacity.zig").QuoteCapacity;
const QuoteConstraint = @import("quote_constraint.zig").QuoteConstraint;
const PaymentOption = @import("payment_option.zig").PaymentOption;
const PaymentTerm = @import("payment_term.zig").PaymentTerm;

/// Summary information about a quote.
pub const QuoteSummary = struct {
    /// The ID of the account that owns the quote.
    account_id: ?[]const u8 = null,

    /// The country code for the Outpost site location.
    country_code: ?[]const u8 = null,

    /// The date the quote was created.
    created_date: ?i64 = null,

    /// The description of the quote.
    description: ?[]const u8 = null,

    /// The date the quote expires.
    expiration_date: ?i64 = null,

    /// The ARN of the Outpost associated with the quote.
    outpost_arn: ?[]const u8 = null,

    /// The ID of the quote.
    quote_id: ?[]const u8 = null,

    /// The configuration and pricing options for the quote.
    quote_options: ?[]const QuoteOption = null,

    /// The status of the quote.
    quote_status: ?QuoteStatus = null,

    /// The capacity requirements specified in the quote request.
    requested_capacities: ?[]const QuoteCapacity = null,

    /// The physical constraints specified in the quote request.
    requested_constraints: ?[]const QuoteConstraint = null,

    /// The payment options specified in the quote request.
    requested_payment_options: ?[]const PaymentOption = null,

    /// The payment terms specified in the quote request.
    requested_payment_terms: ?[]const PaymentTerm = null,

    /// A message about the status of the quote.
    status_message: ?[]const u8 = null,

    /// The ID of the order submitted for the quote.
    submitted_order_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .account_id = "AccountId",
        .country_code = "CountryCode",
        .created_date = "CreatedDate",
        .description = "Description",
        .expiration_date = "ExpirationDate",
        .outpost_arn = "OutpostArn",
        .quote_id = "QuoteId",
        .quote_options = "QuoteOptions",
        .quote_status = "QuoteStatus",
        .requested_capacities = "RequestedCapacities",
        .requested_constraints = "RequestedConstraints",
        .requested_payment_options = "RequestedPaymentOptions",
        .requested_payment_terms = "RequestedPaymentTerms",
        .status_message = "StatusMessage",
        .submitted_order_id = "SubmittedOrderId",
    };
};
