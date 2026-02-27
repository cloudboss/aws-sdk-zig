const IotSiteWiseSourceConfigurationFilter = @import("iot_site_wise_source_configuration_filter.zig").IotSiteWiseSourceConfigurationFilter;

/// The metadata transfer job AWS IoT SiteWise source configuration.
pub const IotSiteWiseSourceConfiguration = struct {
    /// The AWS IoT SiteWise soucre configuration filters.
    filters: ?[]const IotSiteWiseSourceConfigurationFilter,

    pub const json_field_names = .{
        .filters = "filters",
    };
};
