/// Provides information about the resource settings for a job that exports
/// endpoint definitions to a file. The file can be added directly to an Amazon
/// Simple Storage Service (Amazon S3) bucket by using the Amazon Pinpoint API
/// or downloaded directly to a computer by using the Amazon Pinpoint console.
pub const ExportJobResource = struct {
    /// The Amazon Resource Name (ARN) of the AWS Identity and Access Management
    /// (IAM) role that authorized Amazon Pinpoint to access the Amazon S3 location
    /// where the endpoint definitions were exported to.
    role_arn: []const u8,

    /// The URL of the location in an Amazon Simple Storage Service (Amazon S3)
    /// bucket where the endpoint definitions were exported to. This location is
    /// typically a folder that contains multiple files. The URL should be in the
    /// following format: s3://bucket-name/folder-name/.
    s3_url_prefix: []const u8,

    /// The identifier for the segment that the endpoint definitions were exported
    /// from. If this value isn't present, Amazon Pinpoint exported definitions for
    /// all the endpoints that are associated with the application.
    segment_id: ?[]const u8,

    /// The version of the segment that the endpoint definitions were exported from.
    segment_version: ?i32,

    pub const json_field_names = .{
        .role_arn = "RoleArn",
        .s3_url_prefix = "S3UrlPrefix",
        .segment_id = "SegmentId",
        .segment_version = "SegmentVersion",
    };
};
