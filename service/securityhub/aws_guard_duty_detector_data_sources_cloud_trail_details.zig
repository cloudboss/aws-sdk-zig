/// An object that contains information on the status of CloudTrail as a data
/// source for the detector.
pub const AwsGuardDutyDetectorDataSourcesCloudTrailDetails = struct {
    /// Specifies whether CloudTrail is activated as a data source for the detector.
    status: ?[]const u8 = null,

    pub const json_field_names = .{
        .status = "Status",
    };
};
