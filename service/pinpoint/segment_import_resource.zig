const aws = @import("aws");

const Format = @import("format.zig").Format;

/// Provides information about the import job that created a segment. An import
/// job is a job that creates a user segment by importing endpoint definitions.
pub const SegmentImportResource = struct {
    /// The number of channel types in the endpoint definitions that were imported
    /// to create the segment.
    channel_counts: ?[]const aws.map.MapEntry(i32),

    /// (Deprecated) Your AWS account ID, which you assigned to an external ID key
    /// in an IAM trust policy. Amazon Pinpoint previously used this value to assume
    /// an IAM role when importing endpoint definitions, but we removed this
    /// requirement. We don't recommend use of external IDs for IAM roles that are
    /// assumed by Amazon Pinpoint.
    external_id: []const u8,

    /// The format of the files that were imported to create the segment. Valid
    /// values are: CSV, for comma-separated values format; and, JSON, for
    /// newline-delimited JSON format.
    format: Format,

    /// The Amazon Resource Name (ARN) of the AWS Identity and Access Management
    /// (IAM) role that authorized Amazon Pinpoint to access the Amazon S3 location
    /// to import endpoint definitions from.
    role_arn: []const u8,

    /// The URL of the Amazon Simple Storage Service (Amazon S3) bucket that the
    /// endpoint definitions were imported from to create the segment.
    s3_url: []const u8,

    /// The number of endpoint definitions that were imported successfully to create
    /// the segment.
    size: i32,

    pub const json_field_names = .{
        .channel_counts = "ChannelCounts",
        .external_id = "ExternalId",
        .format = "Format",
        .role_arn = "RoleArn",
        .s3_url = "S3Url",
        .size = "Size",
    };
};
