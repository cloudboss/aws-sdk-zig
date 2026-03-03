const CisStringFilter = @import("cis_string_filter.zig").CisStringFilter;
const TagFilter = @import("tag_filter.zig").TagFilter;

/// A list of CIS scan configurations filter criteria.
pub const ListCisScanConfigurationsFilterCriteria = struct {
    /// The list of scan configuration ARN filters.
    scan_configuration_arn_filters: ?[]const CisStringFilter = null,

    /// The list of scan name filters.
    scan_name_filters: ?[]const CisStringFilter = null,

    /// The list of target resource tag filters.
    target_resource_tag_filters: ?[]const TagFilter = null,

    pub const json_field_names = .{
        .scan_configuration_arn_filters = "scanConfigurationArnFilters",
        .scan_name_filters = "scanNameFilters",
        .target_resource_tag_filters = "targetResourceTagFilters",
    };
};
