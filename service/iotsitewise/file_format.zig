const Csv = @import("csv.zig").Csv;
const Parquet = @import("parquet.zig").Parquet;

/// The file format of the data in S3.
pub const FileFormat = struct {
    /// The file is in .CSV format.
    csv: ?Csv = null,

    /// The file is in parquet format.
    parquet: ?Parquet = null,

    pub const json_field_names = .{
        .csv = "csv",
        .parquet = "parquet",
    };
};
