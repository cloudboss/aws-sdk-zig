const ConfigurationSetFilterName = @import("configuration_set_filter_name.zig").ConfigurationSetFilterName;

/// The information for configuration sets that meet a specified criteria.
pub const ConfigurationSetFilter = struct {
    /// The name of the attribute to filter on.
    name: ConfigurationSetFilterName,

    /// An array values to filter for.
    values: []const []const u8,

    pub const json_field_names = .{
        .name = "Name",
        .values = "Values",
    };
};
