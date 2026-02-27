/// Represents the CSV dataset format used when running a monitoring job.
pub const MonitoringCsvDatasetFormat = struct {
    /// Indicates if the CSV data has a header.
    header: ?bool,

    pub const json_field_names = .{
        .header = "Header",
    };
};
