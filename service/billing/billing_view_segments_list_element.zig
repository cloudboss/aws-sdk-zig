const BillingDomain = @import("billing_domain.zig").BillingDomain;
const BillingViewSegmentTimeRange = @import("billing_view_segment_time_range.zig").BillingViewSegmentTimeRange;

/// A billing view segment. A segment represents a time range during which the
/// billing domain and account relationships for a billing view remained
/// unchanged.
pub const BillingViewSegmentsListElement = struct {
    /// The billing group primary account ID. The response includes this field for
    /// billing group members. Compare this value to your own account ID to
    /// determine whether you are the primary account.
    billing_group_primary_account_id: ?[]const u8 = null,

    /// The billing transfer account ID. The response includes this field only when
    /// the caller is a billing transfer source account. The response omits this
    /// field for billing group billing views.
    billing_transfer_account_id: ?[]const u8 = null,

    /// The billing domain for this segment. The following values are valid:
    ///
    /// * `PRO_FORMA` - Data shaped by Billing Conductor that doesn't reflect the
    ///   final charges owed to Amazon Web Services.
    /// * `BILLABLE` - Data that represents the final charges owed to Amazon Web
    ///   Services.
    domain: ?BillingDomain = null,

    /// The management account ID of the organization. The response includes this
    /// field for organization member accounts.
    management_account_id: ?[]const u8 = null,

    /// The time range during which this segment is effective.
    time_range: ?BillingViewSegmentTimeRange = null,

    pub const json_field_names = .{
        .billing_group_primary_account_id = "billingGroupPrimaryAccountId",
        .billing_transfer_account_id = "billingTransferAccountId",
        .domain = "domain",
        .management_account_id = "managementAccountId",
        .time_range = "timeRange",
    };
};
