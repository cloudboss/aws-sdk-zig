const PricingPlan = @import("pricing_plan.zig").PricingPlan;

/// The pricing attributes that apply to your Amazon SES account, including the
/// currently active
/// pricing plan and any scheduled change.
pub const PricingAttributes = struct {
    /// The pricing plan that is currently active on your Amazon SES account.
    current_plan: ?PricingPlan = null,

    /// The pricing plan that will become active at the start of the next monthly
    /// cycle, if a
    /// scheduled change has been requested. This field is empty when no scheduled
    /// change is
    /// pending.
    next_plan: ?PricingPlan = null,

    pub const json_field_names = .{
        .current_plan = "CurrentPlan",
        .next_plan = "NextPlan",
    };
};
