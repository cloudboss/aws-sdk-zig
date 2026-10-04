const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const UpdateTrailInput = struct {
    /// Specifies a log group name using an Amazon Resource Name (ARN), a unique
    /// identifier that
    /// represents the log group to which CloudTrail logs are delivered. You must
    /// use a log
    /// group that exists in your account.
    ///
    /// Not required unless you specify `CloudWatchLogsRoleArn`.
    cloud_watch_logs_log_group_arn: ?[]const u8 = null,

    /// Specifies the role for the CloudWatch Logs endpoint to assume to write to a
    /// user's
    /// log group. You must use a role that exists in your account.
    cloud_watch_logs_role_arn: ?[]const u8 = null,

    /// Specifies whether log file validation is enabled. The default is false.
    ///
    /// When you disable log file integrity validation, the chain of digest files is
    /// broken
    /// after one hour. CloudTrail does not create digest files for log files that
    /// were
    /// delivered during a period in which log file integrity validation was
    /// disabled. For
    /// example, if you enable log file integrity validation at noon on January 1,
    /// disable it at
    /// noon on January 2, and re-enable it at noon on January 10, digest files will
    /// not be
    /// created for the log files delivered from noon on January 2 to noon on
    /// January 10. The
    /// same applies whenever you stop CloudTrail logging or delete a trail.
    enable_log_file_validation: ?bool = null,

    /// Specifies whether the trail is publishing events from global services such
    /// as IAM to the log files. Setting this value to `true` only delivers
    /// global service events to the trail if the trail is multi-Region or if the
    /// trail's home
    /// Region is the partition leader Region (for example, us-east-1).
    include_global_service_events: ?bool = null,

    /// Specifies whether the trail applies only to the current Region or to all
    /// Regions. The
    /// default is false. If the trail exists only in the current Region and this
    /// value is set to
    /// true, shadow trails (replications of the trail) will be created in the other
    /// Regions. If
    /// the trail exists in all Regions and this value is set to false, the trail
    /// will remain in
    /// the Region where it was created, and its shadow trails in other Regions will
    /// be deleted. As
    /// a best practice, consider using trails that log events in all Regions.
    is_multi_region_trail: ?bool = null,

    /// Specifies whether the trail is applied to all accounts in an organization in
    /// Organizations, or only for the current Amazon Web Services account. The
    /// default is false,
    /// and cannot be true unless the call is made on behalf of an Amazon Web
    /// Services account that
    /// is the management account for an organization in Organizations. If the trail
    /// is not an organization trail and this is set to
    /// `true`, the trail will be created in all Amazon Web Services accounts that
    /// belong to the organization. If the trail is an organization trail and this
    /// is set to
    /// `false`, the trail will remain in the current Amazon Web Services account
    /// but
    /// be deleted from all member accounts in the organization.
    ///
    /// Only the management account for the organization can convert an organization
    /// trail to a non-organization trail, or convert a non-organization trail to
    /// an organization trail.
    is_organization_trail: ?bool = null,

    /// Specifies the KMS key ID to use to encrypt the logs and digest files
    /// delivered by CloudTrail. The value can be an alias name prefixed by
    /// "alias/", a fully specified ARN to
    /// an alias, a fully specified ARN to a key, or a globally unique identifier.
    ///
    /// CloudTrail also supports KMS multi-Region keys. For more
    /// information about multi-Region keys, see [Using multi-Region
    /// keys](https://docs.aws.amazon.com/kms/latest/developerguide/multi-region-keys-overview.html) in the *Key Management Service Developer Guide*.
    ///
    /// Examples:
    ///
    /// * alias/MyAliasName
    ///
    /// * arn:aws:kms:us-east-2:123456789012:alias/MyAliasName
    ///
    /// *
    ///   arn:aws:kms:us-east-2:123456789012:key/12345678-1234-1234-1234-123456789012
    ///
    /// * 12345678-1234-1234-1234-123456789012
    kms_key_id: ?[]const u8 = null,

    /// Specifies the name of the trail or trail ARN. If `Name` is a trail name, the
    /// string must meet the following requirements:
    ///
    /// * Contain only ASCII letters (a-z, A-Z), numbers (0-9), periods (.),
    ///   underscores
    /// (_), or dashes (-)
    ///
    /// * Start with a letter or number, and end with a letter or number
    ///
    /// * Be between 3 and 128 characters
    ///
    /// * Have no adjacent periods, underscores or dashes. Names like
    /// `my-_namespace` and `my--namespace` are not valid.
    ///
    /// * Not be in IP address format (for example, 192.168.5.4)
    ///
    /// If `Name` is a trail ARN, it must be in the following format.
    ///
    /// `arn:aws:cloudtrail:us-east-2:123456789012:trail/MyTrail`
    name: []const u8,

    /// Specifies whether recursive logging is enabled for the trail. If you set
    /// `RecursiveLogging` to `false`, CloudTrail suppresses
    /// events generated by CloudTrail when it delivers log files to your trail's
    /// destinations, including Amazon S3 and CloudWatch Logs. The default value is
    /// `true`.
    recursive_logging: ?bool = null,

    /// Specifies the name of the Amazon S3 bucket designated for publishing log
    /// files.
    /// See [Amazon S3
    /// Bucket naming
    /// rules](https://docs.aws.amazon.com/AmazonS3/latest/userguide/bucketnamingrules.html).
    s3_bucket_name: ?[]const u8 = null,

    /// Specifies the Amazon S3 key prefix that comes after the name of the bucket
    /// you
    /// have designated for log file delivery. For more information, see [Finding
    /// Your CloudTrail Log
    /// Files](https://docs.aws.amazon.com/awscloudtrail/latest/userguide/get-and-view-cloudtrail-log-files.html#cloudtrail-find-log-files). The maximum length is 200
    /// characters.
    s3_key_prefix: ?[]const u8 = null,

    /// Specifies the name or ARN of the Amazon SNS topic defined for notification
    /// of log file
    /// delivery. The maximum length is 256 characters.
    sns_topic_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .cloud_watch_logs_log_group_arn = "CloudWatchLogsLogGroupArn",
        .cloud_watch_logs_role_arn = "CloudWatchLogsRoleArn",
        .enable_log_file_validation = "EnableLogFileValidation",
        .include_global_service_events = "IncludeGlobalServiceEvents",
        .is_multi_region_trail = "IsMultiRegionTrail",
        .is_organization_trail = "IsOrganizationTrail",
        .kms_key_id = "KmsKeyId",
        .name = "Name",
        .recursive_logging = "RecursiveLogging",
        .s3_bucket_name = "S3BucketName",
        .s3_key_prefix = "S3KeyPrefix",
        .sns_topic_name = "SnsTopicName",
    };
};

pub const UpdateTrailOutput = struct {
    /// Specifies the Amazon Resource Name (ARN) of the log group to which
    /// CloudTrail
    /// logs are delivered.
    cloud_watch_logs_log_group_arn: ?[]const u8 = null,

    /// Specifies the role for the CloudWatch Logs endpoint to assume to write to a
    /// user's
    /// log group.
    cloud_watch_logs_role_arn: ?[]const u8 = null,

    /// Specifies whether the trail is publishing events from global services such
    /// as IAM to the log files. Setting this value to `true` only delivers
    /// global service events to the trail if the trail is multi-Region or if the
    /// trail's home
    /// Region is the partition leader Region (for example, us-east-1).
    include_global_service_events: ?bool = null,

    /// Specifies whether the trail exists in one Region or in all Regions.
    is_multi_region_trail: ?bool = null,

    /// Specifies whether the trail is an organization trail.
    is_organization_trail: ?bool = null,

    /// Specifies the KMS key ID that encrypts the logs and digest files delivered
    /// by CloudTrail. The value is a fully specified ARN to a KMS key in the
    /// following format.
    ///
    /// `arn:aws:kms:us-east-2:123456789012:key/12345678-1234-1234-1234-123456789012`
    kms_key_id: ?[]const u8 = null,

    /// Specifies whether log file integrity validation is enabled.
    log_file_validation_enabled: ?bool = null,

    /// Specifies the name of the trail.
    name: ?[]const u8 = null,

    /// Specifies whether recursive logging is enabled for the trail.
    recursive_logging: ?bool = null,

    /// Specifies the name of the Amazon S3 bucket designated for publishing log
    /// files.
    s3_bucket_name: ?[]const u8 = null,

    /// Specifies the Amazon S3 key prefix that comes after the name of the bucket
    /// you
    /// have designated for log file delivery. For more information, see [Finding
    /// Your IAM Log
    /// Files](https://docs.aws.amazon.com/awscloudtrail/latest/userguide/get-and-view-cloudtrail-log-files.html#cloudtrail-find-log-files).
    s3_key_prefix: ?[]const u8 = null,

    /// Specifies the ARN of the Amazon SNS topic that CloudTrail uses to send
    /// notifications when log files are delivered. The following is the format of a
    /// topic
    /// ARN.
    ///
    /// `arn:aws:sns:us-east-2:123456789012:MyTopic`
    sns_topic_arn: ?[]const u8 = null,

    /// This field is no longer in use. Use `SnsTopicARN`.
    sns_topic_name: ?[]const u8 = null,

    /// Specifies the ARN of the trail that was updated. The following is the format
    /// of a trail
    /// ARN.
    ///
    /// `arn:aws:cloudtrail:us-east-2:123456789012:trail/MyTrail`
    trail_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .cloud_watch_logs_log_group_arn = "CloudWatchLogsLogGroupArn",
        .cloud_watch_logs_role_arn = "CloudWatchLogsRoleArn",
        .include_global_service_events = "IncludeGlobalServiceEvents",
        .is_multi_region_trail = "IsMultiRegionTrail",
        .is_organization_trail = "IsOrganizationTrail",
        .kms_key_id = "KmsKeyId",
        .log_file_validation_enabled = "LogFileValidationEnabled",
        .name = "Name",
        .recursive_logging = "RecursiveLogging",
        .s3_bucket_name = "S3BucketName",
        .s3_key_prefix = "S3KeyPrefix",
        .sns_topic_arn = "SnsTopicARN",
        .sns_topic_name = "SnsTopicName",
        .trail_arn = "TrailARN",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateTrailInput, options: CallOptions) !UpdateTrailOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "cloudtrail", client.config.http_client.clock_skew_offset);

    var response = try client.config.http_client.sendRequestWithOptions(&request, client.options);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = try parseErrorResponse(client.allocator, response.body, response.status);
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateTrailInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cloudtrail", "CloudTrail", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "CloudTrail_20131101.UpdateTrail");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateTrailOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateTrailOutput, body, allocator);
}
