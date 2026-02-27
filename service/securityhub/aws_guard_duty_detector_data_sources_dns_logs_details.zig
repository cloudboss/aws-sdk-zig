/// An object that contains information on the status of DNS logs as a data
/// source for the detector.
pub const AwsGuardDutyDetectorDataSourcesDnsLogsDetails = struct {
    /// Describes whether DNS logs is enabled as a data source for the detector.
    status: ?[]const u8,

    pub const json_field_names = .{
        .status = "Status",
    };
};
