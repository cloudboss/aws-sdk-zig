const DataSourceStatus = @import("data_source_status.zig").DataSourceStatus;

/// Contains information on the status of VPC flow logs as a data source.
pub const FlowLogsConfigurationResult = struct {
    /// Denotes whether VPC flow logs is enabled as a data source.
    status: DataSourceStatus,

    pub const json_field_names = .{
        .status = "Status",
    };
};
