const Annotation = @import("annotation.zig").Annotation;
const Csv = @import("csv.zig").Csv;
const Mp4 = @import("mp_4.zig").Mp4;
const Parquet = @import("parquet.zig").Parquet;

/// The file format of the data in S3.
pub const FileFormat = struct {
    /// The annotation format configuration.
    annotation: ?Annotation = null,

    /// The file is in .CSV format.
    csv: ?Csv = null,

    /// The MP4 format configuration.
    mp_4: ?Mp4 = null,

    /// The file is in parquet format.
    parquet: ?Parquet = null,

    pub const json_field_names = .{
        .annotation = "annotation",
        .csv = "csv",
        .mp_4 = "mp4",
        .parquet = "parquet",
    };
};
