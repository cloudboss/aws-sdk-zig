const AccessBudget = @import("access_budget.zig").AccessBudget;
const DifferentialPrivacyPrivacyBudget = @import("differential_privacy_privacy_budget.zig").DifferentialPrivacyPrivacyBudget;

/// The epsilon parameter value and number of each aggregation function that you
/// can perform.
pub const PrivacyBudget = union(enum) {
    /// Access budget information associated with this privacy budget.
    access_budget: ?AccessBudget,
    /// An object that specifies the epsilon parameter and the utility in terms of
    /// total aggregations, as well as the remaining aggregations available.
    differential_privacy: ?DifferentialPrivacyPrivacyBudget,

    pub const json_field_names = .{
        .access_budget = "accessBudget",
        .differential_privacy = "differentialPrivacy",
    };
};
