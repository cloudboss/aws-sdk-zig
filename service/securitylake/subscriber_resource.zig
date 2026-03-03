const AccessType = @import("access_type.zig").AccessType;
const LogSourceResource = @import("log_source_resource.zig").LogSourceResource;
const AwsIdentity = @import("aws_identity.zig").AwsIdentity;
const SubscriberStatus = @import("subscriber_status.zig").SubscriberStatus;

/// Provides details about the Amazon Security Lake account subscription.
/// Subscribers are notified
/// of new objects for a source as the data is written to your Amazon S3 bucket
/// for
/// Security Lake.
pub const SubscriberResource = struct {
    /// You can choose to notify subscribers of new objects with an Amazon Simple
    /// Queue Service
    /// (Amazon SQS) queue or through messaging to an HTTPS endpoint provided by the
    /// subscriber.
    ///
    /// Subscribers can consume data by directly querying Lake Formation tables in
    /// your
    /// Amazon S3 bucket through services like Amazon Athena. This subscription
    /// type is defined as `LAKEFORMATION`.
    access_types: ?[]const AccessType = null,

    /// The date and time when the subscriber was created.
    created_at: ?i64 = null,

    /// The Amazon Resource Name (ARN) which uniquely defines the Amazon Web
    /// Services RAM resource share. Before
    /// accepting the RAM resource share invitation, you can view details related to
    /// the RAM
    /// resource share.
    ///
    /// This field is available only for Lake Formation subscribers created after
    /// March 8, 2023.
    resource_share_arn: ?[]const u8 = null,

    /// The name of the resource share.
    resource_share_name: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) specifying the role of the subscriber.
    role_arn: ?[]const u8 = null,

    /// The ARN for the Amazon S3 bucket.
    s_3_bucket_arn: ?[]const u8 = null,

    /// Amazon Security Lake supports log and event collection for natively
    /// supported Amazon Web Services services. For more information, see the
    /// [Amazon Security Lake User
    /// Guide](https://docs.aws.amazon.com/security-lake/latest/userguide/source-management.html).
    sources: []const LogSourceResource,

    /// The subscriber ARN of the Amazon Security Lake subscriber account.
    subscriber_arn: []const u8,

    /// The subscriber descriptions for a subscriber account. The description for a
    /// subscriber
    /// includes `subscriberName`, `accountID`, `externalID`, and
    /// `subscriberId`.
    subscriber_description: ?[]const u8 = null,

    /// The subscriber endpoint to which exception messages are posted.
    subscriber_endpoint: ?[]const u8 = null,

    /// The subscriber ID of the Amazon Security Lake subscriber account.
    subscriber_id: []const u8,

    /// The Amazon Web Services identity used to access your data.
    subscriber_identity: AwsIdentity,

    /// The name of your Amazon Security Lake subscriber account.
    subscriber_name: []const u8,

    /// The subscriber status of the Amazon Security Lake subscriber account.
    subscriber_status: ?SubscriberStatus = null,

    /// The date and time when the subscriber was last updated.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .access_types = "accessTypes",
        .created_at = "createdAt",
        .resource_share_arn = "resourceShareArn",
        .resource_share_name = "resourceShareName",
        .role_arn = "roleArn",
        .s_3_bucket_arn = "s3BucketArn",
        .sources = "sources",
        .subscriber_arn = "subscriberArn",
        .subscriber_description = "subscriberDescription",
        .subscriber_endpoint = "subscriberEndpoint",
        .subscriber_id = "subscriberId",
        .subscriber_identity = "subscriberIdentity",
        .subscriber_name = "subscriberName",
        .subscriber_status = "subscriberStatus",
        .updated_at = "updatedAt",
    };
};
