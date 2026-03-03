const BundleInformation = @import("bundle_information.zig").BundleInformation;
const PricingMode = @import("pricing_mode.zig").PricingMode;
const UpdateReason = @import("update_reason.zig").UpdateReason;

/// The pricing plan.
pub const PricingPlan = struct {
    /// The billable entity count.
    billable_entity_count: ?i64 = null,

    /// The pricing plan's bundle information.
    bundle_information: ?BundleInformation = null,

    /// The effective date and time of the pricing plan.
    effective_date_time: i64,

    /// The pricing mode.
    pricing_mode: PricingMode,

    /// The set date and time for updating a pricing plan.
    update_date_time: i64,

    /// The update reason for changing a pricing plan.
    update_reason: UpdateReason,

    pub const json_field_names = .{
        .billable_entity_count = "billableEntityCount",
        .bundle_information = "bundleInformation",
        .effective_date_time = "effectiveDateTime",
        .pricing_mode = "pricingMode",
        .update_date_time = "updateDateTime",
        .update_reason = "updateReason",
    };
};
