const DataSetExportItem = @import("data_set_export_item.zig").DataSetExportItem;

/// Identifies one or more data sets you want to import with the
/// CreateDataSetExportTask operation.
pub const DataSetExportConfig = union(enum) {
    /// The data sets.
    data_sets: ?[]const DataSetExportItem,
    /// The Amazon S3 location of the data sets.
    s_3_location: ?[]const u8,

    pub const json_field_names = .{
        .data_sets = "dataSets",
        .s_3_location = "s3Location",
    };
};
