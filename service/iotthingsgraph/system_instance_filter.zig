const SystemInstanceFilterName = @import("system_instance_filter_name.zig").SystemInstanceFilterName;

/// An object that filters a system instance search.
/// Multiple filters function as OR criteria in the search. For example a search
/// that includes a GREENGRASS_GROUP_NAME and a
/// STATUS filter searches for system instances in the specified Greengrass
/// group that have the specified status.
pub const SystemInstanceFilter = struct {
    /// The name of the search filter field.
    name: ?SystemInstanceFilterName,

    /// An array of string values for the search filter field. Multiple values
    /// function as AND criteria in the search.
    value: ?[]const []const u8,

    pub const json_field_names = .{
        .name = "name",
        .value = "value",
    };
};
