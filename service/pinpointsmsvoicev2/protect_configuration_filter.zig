const ProtectConfigurationFilterName = @import("protect_configuration_filter_name.zig").ProtectConfigurationFilterName;

/// The filter definition for filtering protect configurations that meet a
/// specified criteria.
pub const ProtectConfigurationFilter = struct {
    /// The name of the attribute to filter on.
    name: ProtectConfigurationFilterName,

    /// An array of values to filter for.
    values: []const []const u8,

    pub const json_field_names = .{
        .name = "Name",
        .values = "Values",
    };
};
