const BusinessSupportDiscount = @import("business_support_discount.zig").BusinessSupportDiscount;
const BusinessSupportServiceSpend = @import("business_support_service_spend.zig").BusinessSupportServiceSpend;
const BusinessSupportTierCharge = @import("business_support_tier_charge.zig").BusinessSupportTierCharge;

/// Business Support charges for a linked account.
pub const BusinessSupportAccountCharge = struct {
    /// The linked account ID.
    account_id: []const u8,

    /// The discount applied to the Business Support charge for this account, if
    /// any. This field is absent when no discount applies.
    support_discount: ?BusinessSupportDiscount = null,

    /// The Support-eligible spend broken down by contributing service for this
    /// account.
    support_eligible_spend_by_service: ?[]const BusinessSupportServiceSpend = null,

    /// The Support plan name for this account. Valid values: `AWSSupportBusiness`
    /// (Business Support plan), `AWSSupportDeveloper` (Developer Support plan),
    /// `AWSSupportEssential` (Basic Support plan).
    support_plan_name: []const u8,

    /// The tier-level charges that make up the total Business Support charge for
    /// this account. Each tier represents a spend range with its own rate.
    tier_charges: ?[]const BusinessSupportTierCharge = null,

    /// The total Business Support charge amount for this account in the billing
    /// month.
    total_charge: []const u8,

    /// The total Support-eligible spend used as the basis for calculating the
    /// Business Support charge for this account.
    total_usage_basis: []const u8,

    pub const json_field_names = .{
        .account_id = "accountId",
        .support_discount = "supportDiscount",
        .support_eligible_spend_by_service = "supportEligibleSpendByService",
        .support_plan_name = "supportPlanName",
        .tier_charges = "tierCharges",
        .total_charge = "totalCharge",
        .total_usage_basis = "totalUsageBasis",
    };
};
