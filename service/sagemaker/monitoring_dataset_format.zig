const MonitoringCsvDatasetFormat = @import("monitoring_csv_dataset_format.zig").MonitoringCsvDatasetFormat;
const MonitoringJsonDatasetFormat = @import("monitoring_json_dataset_format.zig").MonitoringJsonDatasetFormat;
const MonitoringParquetDatasetFormat = @import("monitoring_parquet_dataset_format.zig").MonitoringParquetDatasetFormat;

/// Represents the dataset format used when running a monitoring job.
pub const MonitoringDatasetFormat = struct {
    /// The CSV dataset used in the monitoring job.
    csv: ?MonitoringCsvDatasetFormat,

    /// The JSON dataset used in the monitoring job
    json: ?MonitoringJsonDatasetFormat,

    /// The Parquet dataset used in the monitoring job
    parquet: ?MonitoringParquetDatasetFormat,

    pub const json_field_names = .{
        .csv = "Csv",
        .json = "Json",
        .parquet = "Parquet",
    };
};
