const RegistryRecordFilterName = @import("registry_record_filter_name.zig").RegistryRecordFilterName;

/// A single filter applied to a ListRegistryRecords request.
pub const RegistryRecordFilter = struct {
    /// The attribute to filter on
    name: RegistryRecordFilterName,

    /// The values to match for the attribute
    values: []const []const u8,

    pub const json_field_names = .{
        .name = "name",
        .values = "values",
    };
};
