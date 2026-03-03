/// An object that contains information on the status of VPC Flow Logs as a data
/// source for the detector.
pub const AwsGuardDutyDetectorDataSourcesFlowLogsDetails = struct {
    /// Describes whether VPC Flow Logs are activated as a data source for the
    /// detector.
    status: ?[]const u8 = null,

    pub const json_field_names = .{
        .status = "Status",
    };
};
