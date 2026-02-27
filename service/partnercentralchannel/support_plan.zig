const PartnerLedSupport = @import("partner_led_support.zig").PartnerLedSupport;
const ResoldBusiness = @import("resold_business.zig").ResoldBusiness;
const ResoldEnterprise = @import("resold_enterprise.zig").ResoldEnterprise;

/// Configuration for different types of support plans.
pub const SupportPlan = union(enum) {
    /// Configuration for partner-led support plans.
    partner_led_support: ?PartnerLedSupport,
    /// Configuration for resold business support plans.
    resold_business: ?ResoldBusiness,
    /// Configuration for resold enterprise support plans.
    resold_enterprise: ?ResoldEnterprise,

    pub const json_field_names = .{
        .partner_led_support = "partnerLedSupport",
        .resold_business = "resoldBusiness",
        .resold_enterprise = "resoldEnterprise",
    };
};
