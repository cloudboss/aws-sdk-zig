const SourceDetail = @import("source_detail.zig").SourceDetail;
const DatasetSourceFormat = @import("dataset_source_format.zig").DatasetSourceFormat;
const DatasetSourceType = @import("dataset_source_type.zig").DatasetSourceType;

/// The data source for the dataset.
pub const DatasetSource = struct {
    /// The details of the dataset source associated with the dataset.
    source_detail: ?SourceDetail,

    /// The format of the dataset source associated with the dataset.
    source_format: DatasetSourceFormat,

    /// The type of data source for the dataset.
    source_type: DatasetSourceType,

    pub const json_field_names = .{
        .source_detail = "sourceDetail",
        .source_format = "sourceFormat",
        .source_type = "sourceType",
    };
};
