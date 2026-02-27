const DataSourceStatus = @import("data_source_status.zig").DataSourceStatus;

/// Describes whether S3 data event logs will be enabled as a data source.
pub const S3LogsConfigurationResult = struct {
    /// A value that describes whether S3 data event logs are automatically enabled
    /// for new
    /// members of the organization.
    status: DataSourceStatus,

    pub const json_field_names = .{
        .status = "Status",
    };
};
