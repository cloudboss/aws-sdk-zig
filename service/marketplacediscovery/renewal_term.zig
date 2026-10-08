const PriceIncrease = @import("price_increase.zig").PriceIncrease;
const TermTemplate = @import("term_template.zig").TermTemplate;
const TermType = @import("term_type.zig").TermType;

/// Defines a renewal term that enables automatic agreement renewal.
pub const RenewalTerm = struct {
    /// The duration before the agreement end date by which the renewal price is
    /// finalized, represented in ISO 8601 format (for example, P30D). Only
    /// applicable with `PercentageRange`.
    adjustment_deadline: ?[]const u8 = null,

    /// The unique identifier of the term.
    id: []const u8,

    /// The duration before the agreement end date when the lockout window begins,
    /// in ISO 8601 format (for example, P30D). Absent means no lockout.
    lockout_period: ?[]const u8 = null,

    /// The maximum number of renewals allowed on this offer. Absent means unlimited
    /// renewals.
    max_renewals: ?i32 = null,

    /// The price increase applied at each renewal cycle. Absent means identical
    /// pricing on renewal.
    price_increase: ?PriceIncrease = null,

    /// Structural templates defining how specific terms are reshaped on each
    /// renewal cycle. Absent for upfront-only offers.
    term_templates: ?[]const TermTemplate = null,

    /// The category of the term.
    type: TermType,

    pub const json_field_names = .{
        .adjustment_deadline = "adjustmentDeadline",
        .id = "id",
        .lockout_period = "lockoutPeriod",
        .max_renewals = "maxRenewals",
        .price_increase = "priceIncrease",
        .term_templates = "termTemplates",
        .type = "type",
    };
};
