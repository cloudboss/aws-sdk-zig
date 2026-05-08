const EstimatedTaxes = @import("estimated_taxes.zig").EstimatedTaxes;
const Timing = @import("timing.zig").Timing;

/// Estimated charge for the request.
pub const ExpectedCharge = struct {
    /// The tax-exclusive amount of the charge. Only available when the charge
    /// amount is known.
    amount: ?[]const u8 = null,

    /// The tax-inclusive amount the acceptor has to pay. The amount is only present
    /// for fixed charges.
    amount_after_tax: ?[]const u8 = null,

    /// Provides an aggregated view of estimated tax information for this specific
    /// charge.
    estimated_taxes: ?EstimatedTaxes = null,

    /// Unique identifier of the charge for a given agreement.
    id: ?[]const u8 = null,

    /// The date and time when the charge is due to be invoiced. This is available
    /// only when the charge date is known.
    time: ?i64 = null,

    /// Indicates when the charge amount will be incurred. Values include
    /// `ON_ACCEPTANCE` (charged immediately when the agreement request is
    /// accepted), `BILLING_PERIOD` (charged on each billing period), and
    /// `SCHEDULED` (charged at a predetermined future date).
    timing: ?Timing = null,

    pub const json_field_names = .{
        .amount = "amount",
        .amount_after_tax = "amountAfterTax",
        .estimated_taxes = "estimatedTaxes",
        .id = "id",
        .time = "time",
        .timing = "timing",
    };
};
