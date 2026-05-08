const BillingPeriod = @import("billing_period.zig").BillingPeriod;
const ReceiverRole = @import("receiver_role.zig").ReceiverRole;
const DateInterval = @import("date_interval.zig").DateInterval;

/// Filters for your invoice summaries.
pub const InvoiceSummariesFilter = struct {
    /// The billing period associated with the invoice documents.
    billing_period: ?BillingPeriod = null,

    /// The name of the entity that issues the Amazon Web Services invoice.
    invoicing_entity: ?[]const u8 = null,

    /// The role of the invoice receiver to filter by.
    ///
    /// When `ReceiverRole` is specified:
    ///
    /// * Data is available starting `2025-06-01`. Queries for periods before
    ///   `2025-06-01` return a validation error.
    /// * `TimeInterval` supports a time interval of up to 5 years. Without
    ///   `ReceiverRole`, `TimeInterval` is limited to one month.
    receiver_role: ?ReceiverRole = null,

    /// The date range for invoice summary retrieval.
    time_interval: ?DateInterval = null,

    pub const json_field_names = .{
        .billing_period = "BillingPeriod",
        .invoicing_entity = "InvoicingEntity",
        .receiver_role = "ReceiverRole",
        .time_interval = "TimeInterval",
    };
};
