const NotifyConfigurationFilterName = @import("notify_configuration_filter_name.zig").NotifyConfigurationFilterName;

/// The information for notify configurations that meet a specified criteria.
pub const NotifyConfigurationFilter = struct {
    /// The name of the attribute to filter on.
    name: NotifyConfigurationFilterName,

    /// An array values to filter for.
    values: []const []const u8,

    pub const json_field_names = .{
        .name = "Name",
        .values = "Values",
    };
};
