const DataSetImportItem = @import("data_set_import_item.zig").DataSetImportItem;

/// Identifies one or more data sets you want to import with the
/// CreateDataSetImportTask operation.
pub const DataSetImportConfig = union(enum) {
    /// The data sets.
    data_sets: ?[]const DataSetImportItem,
    /// The Amazon S3 location of the data sets.
    s_3_location: ?[]const u8,

    pub const json_field_names = .{
        .data_sets = "dataSets",
        .s_3_location = "s3Location",
    };
};
