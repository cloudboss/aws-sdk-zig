/// Specifies settings for publishing event data to an Amazon Kinesis data
/// stream or an Amazon Kinesis Data Firehose delivery stream.
pub const EventStream = struct {
    /// The unique identifier for the application to publish event data for.
    application_id: []const u8,

    /// The Amazon Resource Name (ARN) of the Amazon Kinesis data stream or Amazon
    /// Kinesis Data Firehose delivery stream to publish event data to.
    ///
    /// For a Kinesis data stream, the ARN format is:
    /// arn:aws:kinesis:region:account-id:stream/stream_name
    ///
    /// For a Kinesis Data Firehose delivery stream, the ARN format is:
    /// arn:aws:firehose:region:account-id:deliverystream/stream_name
    destination_stream_arn: []const u8,

    /// (Deprecated) Your AWS account ID, which you assigned to an external ID key
    /// in an IAM trust policy. Amazon Pinpoint previously used this value to assume
    /// an IAM role when publishing event data, but we removed this requirement. We
    /// don't recommend use of external IDs for IAM roles that are assumed by Amazon
    /// Pinpoint.
    external_id: ?[]const u8 = null,

    /// The date, in ISO 8601 format, when the event stream was last modified.
    last_modified_date: ?[]const u8 = null,

    /// The IAM user who last modified the event stream.
    last_updated_by: ?[]const u8 = null,

    /// The AWS Identity and Access Management (IAM) role that authorizes Amazon
    /// Pinpoint to publish event data to the stream in your AWS account.
    role_arn: []const u8,

    pub const json_field_names = .{
        .application_id = "ApplicationId",
        .destination_stream_arn = "DestinationStreamArn",
        .external_id = "ExternalId",
        .last_modified_date = "LastModifiedDate",
        .last_updated_by = "LastUpdatedBy",
        .role_arn = "RoleArn",
    };
};
