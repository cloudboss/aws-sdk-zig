/// Estimated discount details of the current and recommended resource
/// configuration for a recommendation.
pub const EstimatedDiscounts = struct {
    /// Estimated other discounts include all discounts that are not itemized.
    /// Itemized discounts include `reservedInstanceDiscount` and
    /// `savingsPlansDiscount`.
    other_discount: ?f64,

    /// Estimated reserved instance discounts.
    reserved_instances_discount: ?f64,

    /// Estimated Savings Plans discounts.
    savings_plans_discount: ?f64,

    pub const json_field_names = .{
        .other_discount = "otherDiscount",
        .reserved_instances_discount = "reservedInstancesDiscount",
        .savings_plans_discount = "savingsPlansDiscount",
    };
};
