const CsvConfiguration = @import("csv_configuration.zig").CsvConfiguration;
const BatchLoadDataFormat = @import("batch_load_data_format.zig").BatchLoadDataFormat;
const DataSourceS3Configuration = @import("data_source_s3_configuration.zig").DataSourceS3Configuration;

/// Defines configuration details about the data source.
pub const DataSourceConfiguration = struct {
    csv_configuration: ?CsvConfiguration = null,

    /// This is currently CSV.
    data_format: BatchLoadDataFormat,

    /// Configuration of an S3 location for a file which contains data to load.
    data_source_s3_configuration: DataSourceS3Configuration,

    pub const json_field_names = .{
        .csv_configuration = "CsvConfiguration",
        .data_format = "DataFormat",
        .data_source_s3_configuration = "DataSourceS3Configuration",
    };
};
