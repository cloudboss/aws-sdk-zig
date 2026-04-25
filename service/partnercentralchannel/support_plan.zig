const PartnerLedSupport = @import("partner_led_support.zig").PartnerLedSupport;
const ResoldEnterprise = @import("resold_enterprise.zig").ResoldEnterprise;
const ResoldUnifiedOperations = @import("resold_unified_operations.zig").ResoldUnifiedOperations;

/// Configuration for different types of support plans.
pub const SupportPlan = union(enum) {
    /// Configuration for partner-led support plans.
    partner_led_support: ?PartnerLedSupport,
    /// Configuration for resold enterprise support plans.
    resold_enterprise: ?ResoldEnterprise,
    /// Configuration for resold unified operations support plans.
    resold_unified_operations: ?ResoldUnifiedOperations,

    pub const json_field_names = .{
        .partner_led_support = "partnerLedSupport",
        .resold_enterprise = "resoldEnterprise",
        .resold_unified_operations = "resoldUnifiedOperations",
    };
};
