const DataSourceStatus = @import("data_source_status.zig").DataSourceStatus;

/// Contains information on the status of DNS logs as a data source.
pub const DNSLogsConfigurationResult = struct {
    /// Denotes whether DNS logs is enabled as a data source.
    status: DataSourceStatus,

    pub const json_field_names = .{
        .status = "Status",
    };
};
