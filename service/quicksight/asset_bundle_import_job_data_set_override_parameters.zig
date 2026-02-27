const DataSetRefreshProperties = @import("data_set_refresh_properties.zig").DataSetRefreshProperties;

/// The override parameters for a single dataset that is being imported.
pub const AssetBundleImportJobDataSetOverrideParameters = struct {
    /// The ID of the dataset to apply overrides to.
    data_set_id: []const u8,

    data_set_refresh_properties: ?DataSetRefreshProperties,

    /// A new name for the dataset.
    name: ?[]const u8,

    pub const json_field_names = .{
        .data_set_id = "DataSetId",
        .data_set_refresh_properties = "DataSetRefreshProperties",
        .name = "Name",
    };
};
