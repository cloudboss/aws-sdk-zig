/// A single entry in an image usage report, detailing how an image is being
/// used by a
/// specific Amazon Web Services account and resource type.
pub const ImageUsageReportEntry = struct {
    /// The ID of the account that uses the image.
    account_id: ?[]const u8 = null,

    /// The ID of the image.
    image_id: ?[]const u8 = null,

    /// The date and time the report creation was initiated.
    report_creation_time: ?i64 = null,

    /// The ID of the report.
    report_id: ?[]const u8 = null,

    /// The type of resource (`ec2:Instance` or
    /// `ec2:LaunchTemplate`).
    resource_type: ?[]const u8 = null,

    /// The number of times resources of this type reference this image in the
    /// account.
    usage_count: ?i64 = null,
};
