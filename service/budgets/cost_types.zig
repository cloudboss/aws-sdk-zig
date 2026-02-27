/// The types of cost that are included in a `COST` budget, such as tax and
/// subscriptions.
///
/// `USAGE`, `RI_UTILIZATION`, `RI_COVERAGE`,
/// `SAVINGS_PLANS_UTILIZATION`, and `SAVINGS_PLANS_COVERAGE`
/// budgets don't have `CostTypes`.
pub const CostTypes = struct {
    /// Specifies whether a budget includes credits.
    ///
    /// The default value is `true`.
    include_credit: ?bool,

    /// Specifies whether a budget includes discounts.
    ///
    /// The default value is `true`.
    include_discount: ?bool,

    /// Specifies whether a budget includes non-RI subscription costs.
    ///
    /// The default value is `true`.
    include_other_subscription: ?bool,

    /// Specifies whether a budget includes recurring fees such as monthly RI fees.
    ///
    /// The default value is `true`.
    include_recurring: ?bool,

    /// Specifies whether a budget includes refunds.
    ///
    /// The default value is `true`.
    include_refund: ?bool,

    /// Specifies whether a budget includes subscriptions.
    ///
    /// The default value is `true`.
    include_subscription: ?bool,

    /// Specifies whether a budget includes support subscription fees.
    ///
    /// The default value is `true`.
    include_support: ?bool,

    /// Specifies whether a budget includes taxes.
    ///
    /// The default value is `true`.
    include_tax: ?bool,

    /// Specifies whether a budget includes upfront RI costs.
    ///
    /// The default value is `true`.
    include_upfront: ?bool,

    /// Specifies whether a budget uses the amortized rate.
    ///
    /// The default value is `false`.
    use_amortized: ?bool,

    /// Specifies whether a budget uses a blended rate.
    ///
    /// The default value is `false`.
    use_blended: ?bool,

    pub const json_field_names = .{
        .include_credit = "IncludeCredit",
        .include_discount = "IncludeDiscount",
        .include_other_subscription = "IncludeOtherSubscription",
        .include_recurring = "IncludeRecurring",
        .include_refund = "IncludeRefund",
        .include_subscription = "IncludeSubscription",
        .include_support = "IncludeSupport",
        .include_tax = "IncludeTax",
        .include_upfront = "IncludeUpfront",
        .use_amortized = "UseAmortized",
        .use_blended = "UseBlended",
    };
};
