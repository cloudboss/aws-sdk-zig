const BillingPeriod = @import("billing_period.zig").BillingPeriod;
const DateInterval = @import("date_interval.zig").DateInterval;

/// Filters for your invoice summaries.
pub const InvoiceSummariesFilter = struct {
    /// The billing period associated with the invoice documents.
    billing_period: ?BillingPeriod = null,

    /// The name of the entity that issues the Amazon Web Services invoice.
    invoicing_entity: ?[]const u8 = null,

    /// The date range for invoice summary retrieval.
    time_interval: ?DateInterval = null,

    pub const json_field_names = .{
        .billing_period = "BillingPeriod",
        .invoicing_entity = "InvoicingEntity",
        .time_interval = "TimeInterval",
    };
};
