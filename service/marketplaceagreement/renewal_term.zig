const RenewalTermConfiguration = @import("renewal_term_configuration.zig").RenewalTermConfiguration;
const PriceIncrease = @import("price_increase.zig").PriceIncrease;
const TermTemplate = @import("term_template.zig").TermTemplate;

/// Defines that on graceful expiration of the agreement (when the agreement
/// ends on its pre-defined end date), a new agreement will be created using the
/// accepted terms on the existing agreement. In other words, the agreement will
/// be renewed. Presence of `RenewalTerm` in the offer document means that
/// auto-renewal is allowed. The acceptor will have the option to accept or
/// decline auto-renewal at the offer acceptance/agreement creation. The
/// acceptor can also change this flag from `True` to `False` or `False` to
/// `True`, within the limits set by `LockoutPeriod` and `MaxRenewals`. Setting
/// the flag to `True` doesn't by itself guarantee that the agreement renews,
/// because the proposer can also opt out.
pub const RenewalTerm = struct {
    /// The date by which the proposer must finalize the price increase for the next
    /// renewal, measured back from the end date of the agreement. The duration is
    /// represented in the ISO 8601 format in whole days (for example, `P30D` for 30
    /// days or `P60D` for 60 days).
    ///
    /// This field applies only when `PriceIncrease` is a `PercentageRange`. The
    /// field is `null` when `PriceIncrease` is a `FixedPercentage`, because the
    /// price increase is already fixed and there is nothing for the proposer to
    /// finalize. If the proposer doesn't finalize a value by the adjustment
    /// deadline, the `DefaultValue` of the range applies.
    ///
    /// `AdjustmentDeadline` must be greater than `LockoutPeriod`.
    adjustment_deadline: ?[]const u8 = null,

    /// Additional parameters specified by the acceptor while accepting the term.
    configuration: ?RenewalTermConfiguration = null,

    /// The unique identifier for the term.
    id: ?[]const u8 = null,

    /// The renewal decision deadline, measured back from the end date of the
    /// agreement. This is the last day either party can opt in to or opt out of the
    /// renewal. The duration is represented in the ISO 8601 format in whole days
    /// (for example, `P30D` for 30 days or `P60D` for 60 days).
    ///
    /// The field is `null` when no renewal decision deadline is set. In that case,
    /// either party can change the auto-renewal decision up to the end date of the
    /// agreement.
    lockout_period: ?[]const u8 = null,

    /// The maximum number of times the agreement can be renewed. The field is
    /// `null` when the number of renewals is unlimited.
    ///
    /// After the agreement reaches this limit, it expires on its end date instead
    /// of renewing.
    max_renewals: ?i32 = null,

    /// The price increase that is applied each time the agreement renews. The field
    /// is `null` when the price doesn't change at renewal.
    price_increase: ?PriceIncrease = null,

    /// Defines how specific terms change each time the agreement renews. The field
    /// is `null` when no terms change at renewal.
    term_templates: ?[]const TermTemplate = null,

    /// Category of the term being updated.
    @"type": ?[]const u8 = null,

    pub const json_field_names = .{
        .adjustment_deadline = "adjustmentDeadline",
        .configuration = "configuration",
        .id = "id",
        .lockout_period = "lockoutPeriod",
        .max_renewals = "maxRenewals",
        .price_increase = "priceIncrease",
        .term_templates = "termTemplates",
        .@"type" = "type",
    };
};
