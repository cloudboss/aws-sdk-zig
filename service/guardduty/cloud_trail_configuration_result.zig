const DataSourceStatus = @import("data_source_status.zig").DataSourceStatus;

/// Contains information on the status of CloudTrail as a data source for the
/// detector.
pub const CloudTrailConfigurationResult = struct {
    /// Describes whether CloudTrail is enabled as a data source for the detector.
    status: DataSourceStatus,

    pub const json_field_names = .{
        .status = "Status",
    };
};
