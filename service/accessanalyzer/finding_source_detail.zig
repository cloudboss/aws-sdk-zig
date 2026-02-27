/// Includes details about how the access that generated the finding is granted.
/// This is populated for Amazon S3 bucket findings.
pub const FindingSourceDetail = struct {
    /// The account of the cross-account access point that generated the finding.
    access_point_account: ?[]const u8,

    /// The ARN of the access point that generated the finding. The ARN format
    /// depends on whether the ARN represents an access point or a multi-region
    /// access point.
    access_point_arn: ?[]const u8,

    pub const json_field_names = .{
        .access_point_account = "accessPointAccount",
        .access_point_arn = "accessPointArn",
    };
};
