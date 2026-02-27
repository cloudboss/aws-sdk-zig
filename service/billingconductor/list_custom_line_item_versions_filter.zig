const ListCustomLineItemVersionsBillingPeriodRangeFilter = @import("list_custom_line_item_versions_billing_period_range_filter.zig").ListCustomLineItemVersionsBillingPeriodRangeFilter;

/// A filter that specifies the billing period range where the custom line item
/// versions reside.
pub const ListCustomLineItemVersionsFilter = struct {
    /// The billing period range in which the custom line item version is applied.
    billing_period_range: ?ListCustomLineItemVersionsBillingPeriodRangeFilter,

    pub const json_field_names = .{
        .billing_period_range = "BillingPeriodRange",
    };
};
