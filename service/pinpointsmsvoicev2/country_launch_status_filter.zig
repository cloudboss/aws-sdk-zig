const CountryLaunchStatusFilterName = @import("country_launch_status_filter_name.zig").CountryLaunchStatusFilterName;

/// The information for a country launch status that meets a specified criteria.
pub const CountryLaunchStatusFilter = struct {
    /// The name of the attribute to filter on.
    name: CountryLaunchStatusFilterName,

    /// An array values to filter for.
    values: []const []const u8,

    pub const json_field_names = .{
        .name = "Name",
        .values = "Values",
    };
};
