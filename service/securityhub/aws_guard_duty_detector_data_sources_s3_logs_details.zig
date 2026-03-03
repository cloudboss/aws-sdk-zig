/// An object that contains information on the status of S3 data event logs as a
/// data source for the detector.
pub const AwsGuardDutyDetectorDataSourcesS3LogsDetails = struct {
    /// A value that describes whether S3 data event logs are automatically enabled
    /// for new members of an organization.
    status: ?[]const u8 = null,

    pub const json_field_names = .{
        .status = "Status",
    };
};
