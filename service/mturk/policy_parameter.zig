const ParameterMapEntry = @import("parameter_map_entry.zig").ParameterMapEntry;

/// Name of the parameter from the Review policy.
pub const PolicyParameter = struct {
    /// Name of the parameter from the list of Review Polices.
    key: ?[]const u8 = null,

    /// List of ParameterMapEntry objects.
    map_entries: ?[]const ParameterMapEntry = null,

    /// The list of values of the Parameter
    values: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .key = "Key",
        .map_entries = "MapEntries",
        .values = "Values",
    };
};
