const DataSet = @import("data_set.zig").DataSet;
const ExternalLocation = @import("external_location.zig").ExternalLocation;

/// Identifies a specific data set to import from an external location.
pub const DataSetImportItem = struct {
    /// The data set.
    data_set: DataSet,

    /// The location of the data set.
    external_location: ExternalLocation,

    pub const json_field_names = .{
        .data_set = "dataSet",
        .external_location = "externalLocation",
    };
};
