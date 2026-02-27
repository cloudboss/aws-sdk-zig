const EksAnywhereSubscriptionTermUnit = @import("eks_anywhere_subscription_term_unit.zig").EksAnywhereSubscriptionTermUnit;

/// An object representing the term duration and term unit type of your
/// subscription. This
/// determines the term length of your subscription. Valid values are MONTHS for
/// term unit
/// and 12 or 36 for term duration, indicating a 12 month or 36 month
/// subscription.
pub const EksAnywhereSubscriptionTerm = struct {
    /// The duration of the subscription term. Valid values are 12 and 36,
    /// indicating a 12
    /// month or 36 month subscription.
    duration: i32 = 0,

    /// The term unit of the subscription. Valid value is `MONTHS`.
    unit: ?EksAnywhereSubscriptionTermUnit,

    pub const json_field_names = .{
        .duration = "duration",
        .unit = "unit",
    };
};
