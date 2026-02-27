const CisNumberFilter = @import("cis_number_filter.zig").CisNumberFilter;
const CisStringFilter = @import("cis_string_filter.zig").CisStringFilter;
const CisDateFilter = @import("cis_date_filter.zig").CisDateFilter;
const CisScanStatusFilter = @import("cis_scan_status_filter.zig").CisScanStatusFilter;
const TagFilter = @import("tag_filter.zig").TagFilter;

/// A list of CIS scans filter criteria.
pub const ListCisScansFilterCriteria = struct {
    /// The list of failed checks filters.
    failed_checks_filters: ?[]const CisNumberFilter,

    /// The list of scan ARN filters.
    scan_arn_filters: ?[]const CisStringFilter,

    /// The list of scan at filters.
    scan_at_filters: ?[]const CisDateFilter,

    /// The list of scan configuration ARN filters.
    scan_configuration_arn_filters: ?[]const CisStringFilter,

    /// The list of scan name filters.
    scan_name_filters: ?[]const CisStringFilter,

    /// The list of scan status filters.
    scan_status_filters: ?[]const CisScanStatusFilter,

    /// The list of scheduled by filters.
    scheduled_by_filters: ?[]const CisStringFilter,

    /// The list of target account ID filters.
    target_account_id_filters: ?[]const CisStringFilter,

    /// The list of target resource ID filters.
    target_resource_id_filters: ?[]const CisStringFilter,

    /// The list of target resource tag filters.
    target_resource_tag_filters: ?[]const TagFilter,

    pub const json_field_names = .{
        .failed_checks_filters = "failedChecksFilters",
        .scan_arn_filters = "scanArnFilters",
        .scan_at_filters = "scanAtFilters",
        .scan_configuration_arn_filters = "scanConfigurationArnFilters",
        .scan_name_filters = "scanNameFilters",
        .scan_status_filters = "scanStatusFilters",
        .scheduled_by_filters = "scheduledByFilters",
        .target_account_id_filters = "targetAccountIdFilters",
        .target_resource_id_filters = "targetResourceIdFilters",
        .target_resource_tag_filters = "targetResourceTagFilters",
    };
};
