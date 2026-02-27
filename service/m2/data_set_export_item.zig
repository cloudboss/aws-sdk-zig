const ExternalLocation = @import("external_location.zig").ExternalLocation;

/// Identifies a specific data set to export from an external location.
pub const DataSetExportItem = struct {
    /// The data set.
    dataset_name: []const u8,

    /// The location of the data set.
    external_location: ExternalLocation,

    pub const json_field_names = .{
        .dataset_name = "datasetName",
        .external_location = "externalLocation",
    };
};
