/// Specifies the settings for a job that exports endpoint definitions to an
/// Amazon Simple Storage Service (Amazon S3) bucket.
pub const ExportJobRequest = struct {
    /// The Amazon Resource Name (ARN) of the AWS Identity and Access Management
    /// (IAM) role that authorizes Amazon Pinpoint to access the Amazon S3 location
    /// where you want to export endpoint definitions to.
    role_arn: []const u8,

    /// The URL of the location in an Amazon Simple Storage Service (Amazon S3)
    /// bucket where you want to export endpoint definitions to. This location is
    /// typically a folder that contains multiple files. The URL should be in the
    /// following format: s3://bucket-name/folder-name/.
    s3_url_prefix: []const u8,

    /// The identifier for the segment to export endpoint definitions from. If you
    /// don't specify this value, Amazon Pinpoint exports definitions for all the
    /// endpoints that are associated with the application.
    segment_id: ?[]const u8 = null,

    /// The version of the segment to export endpoint definitions from, if
    /// specified.
    segment_version: ?i32 = null,

    pub const json_field_names = .{
        .role_arn = "RoleArn",
        .s3_url_prefix = "S3UrlPrefix",
        .segment_id = "SegmentId",
        .segment_version = "SegmentVersion",
    };
};
