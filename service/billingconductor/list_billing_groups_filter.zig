const BillingGroupType = @import("billing_group_type.zig").BillingGroupType;
const StringSearch = @import("string_search.zig").StringSearch;
const BillingGroupStatus = @import("billing_group_status.zig").BillingGroupStatus;

/// The filter that specifies the billing groups and pricing plans to retrieve
/// billing group information.
pub const ListBillingGroupsFilter = struct {
    /// The list of billing group Amazon Resource Names (ARNs) to retrieve
    /// information.
    arns: ?[]const []const u8 = null,

    /// Specifies if this billing group will automatically associate newly added
    /// Amazon Web Services accounts that join your consolidated billing family.
    auto_associate: ?bool = null,

    /// Filter billing groups by their type.
    billing_group_types: ?[]const BillingGroupType = null,

    /// Filter billing groups by their names.
    names: ?[]const StringSearch = null,

    /// The pricing plan Amazon Resource Names (ARNs) to retrieve information.
    pricing_plan: ?[]const u8 = null,

    /// A list of primary account IDs to filter the billing groups.
    primary_account_ids: ?[]const []const u8 = null,

    /// Filter billing groups by their responsibility transfer ARNs.
    responsibility_transfer_arns: ?[]const []const u8 = null,

    /// A list of billing groups to retrieve their current status for a specific
    /// time range
    statuses: ?[]const BillingGroupStatus = null,

    pub const json_field_names = .{
        .arns = "Arns",
        .auto_associate = "AutoAssociate",
        .billing_group_types = "BillingGroupTypes",
        .names = "Names",
        .pricing_plan = "PricingPlan",
        .primary_account_ids = "PrimaryAccountIds",
        .responsibility_transfer_arns = "ResponsibilityTransferArns",
        .statuses = "Statuses",
    };
};
