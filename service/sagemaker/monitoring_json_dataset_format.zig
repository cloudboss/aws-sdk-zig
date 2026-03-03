/// Represents the JSON dataset format used when running a monitoring job.
pub const MonitoringJsonDatasetFormat = struct {
    /// Indicates if the file should be read as a JSON object per line.
    line: ?bool = null,

    pub const json_field_names = .{
        .line = "Line",
    };
};
