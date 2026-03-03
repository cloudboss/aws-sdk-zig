const CisStringFilter = @import("cis_string_filter.zig").CisStringFilter;
const CisNumberFilter = @import("cis_number_filter.zig").CisNumberFilter;
const CisResultStatusFilter = @import("cis_result_status_filter.zig").CisResultStatusFilter;
const TagFilter = @import("tag_filter.zig").TagFilter;
const CisTargetStatusFilter = @import("cis_target_status_filter.zig").CisTargetStatusFilter;
const CisTargetStatusReasonFilter = @import("cis_target_status_reason_filter.zig").CisTargetStatusReasonFilter;

/// The scan results aggregated by target resource filter criteria.
pub const CisScanResultsAggregatedByTargetResourceFilterCriteria = struct {
    /// The criteria's account ID filters.
    account_id_filters: ?[]const CisStringFilter = null,

    /// The criteria's check ID filters.
    check_id_filters: ?[]const CisStringFilter = null,

    /// The criteria's failed checks filters.
    failed_checks_filters: ?[]const CisNumberFilter = null,

    /// The criteria's platform filters.
    platform_filters: ?[]const CisStringFilter = null,

    /// The criteria's status filter.
    status_filters: ?[]const CisResultStatusFilter = null,

    /// The criteria's target resource ID filters.
    target_resource_id_filters: ?[]const CisStringFilter = null,

    /// The criteria's target resource tag filters.
    target_resource_tag_filters: ?[]const TagFilter = null,

    /// The criteria's target status filters.
    target_status_filters: ?[]const CisTargetStatusFilter = null,

    /// The criteria's target status reason filters.
    target_status_reason_filters: ?[]const CisTargetStatusReasonFilter = null,

    pub const json_field_names = .{
        .account_id_filters = "accountIdFilters",
        .check_id_filters = "checkIdFilters",
        .failed_checks_filters = "failedChecksFilters",
        .platform_filters = "platformFilters",
        .status_filters = "statusFilters",
        .target_resource_id_filters = "targetResourceIdFilters",
        .target_resource_tag_filters = "targetResourceTagFilters",
        .target_status_filters = "targetStatusFilters",
        .target_status_reason_filters = "targetStatusReasonFilters",
    };
};
