const ExportDataType = @import("export_data_type.zig").ExportDataType;
const TrimSettings = @import("trim_settings.zig").TrimSettings;

/// A dataset to process.
pub const DatasetItem = struct {
    /// The unique identifier for the dataset.
    dataset_id: []const u8,

    /// The optional subset of data types to export. If omitted, all data types are
    /// exported.
    export_data_types: ?[]const ExportDataType = null,

    /// The trim settings applied to all items in the dataset. When omitted, the
    /// full dataset time range is used.
    trim_settings: ?TrimSettings = null,

    pub const json_field_names = .{
        .dataset_id = "datasetId",
        .export_data_types = "exportDataTypes",
        .trim_settings = "trimSettings",
    };
};
