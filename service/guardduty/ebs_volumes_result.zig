const DataSourceStatus = @import("data_source_status.zig").DataSourceStatus;

/// Describes the configuration of scanning EBS volumes as a data source.
pub const EbsVolumesResult = struct {
    /// Specifies the reason why scanning EBS volumes (Malware Protection) was not
    /// enabled as a data source.
    reason: ?[]const u8 = null,

    /// Describes whether scanning EBS volumes is enabled as a data source.
    status: ?DataSourceStatus = null,

    pub const json_field_names = .{
        .reason = "Reason",
        .status = "Status",
    };
};
