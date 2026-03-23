const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const Tag = @import("tag.zig").Tag;

pub const CreateTrailInput = struct {
    /// Specifies a log group name using an Amazon Resource Name (ARN), a unique
    /// identifier that
    /// represents the log group to which CloudTrail logs will be delivered. You
    /// must use a
    /// log group that exists in your account.
    ///
    /// Not required unless you specify `CloudWatchLogsRoleArn`.
    cloud_watch_logs_log_group_arn: ?[]const u8 = null,

    /// Specifies the role for the CloudWatch Logs endpoint to assume to write to a
    /// user's
    /// log group. You must use a role that exists in your account.
    cloud_watch_logs_role_arn: ?[]const u8 = null,

    /// Specifies whether log file integrity validation is enabled. The default is
    /// false.
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
    /// as IAM to the
    /// log files.
    include_global_service_events: ?bool = null,

    /// Specifies whether the trail is created in the current Region or in all
    /// Regions. The
    /// default is false, which creates a trail only in the Region where you are
    /// signed in. As a
    /// best practice, consider creating trails that log events in all Regions.
    is_multi_region_trail: ?bool = null,

    /// Specifies whether the trail is created for all accounts in an organization
    /// in Organizations, or only for the current Amazon Web Services account. The
    /// default is false,
    /// and cannot be true unless the call is made on behalf of an Amazon Web
    /// Services account that
    /// is the management account or delegated administrator account for an
    /// organization in Organizations.
    is_organization_trail: ?bool = null,

    /// Specifies the KMS key ID to use to encrypt the logs and digest files
    /// delivered by CloudTrail. The value can be an alias name prefixed by
    /// `alias/`, a fully
    /// specified ARN to an alias, a fully specified ARN to a key, or a globally
    /// unique
    /// identifier.
    ///
    /// CloudTrail also supports KMS multi-Region keys. For more
    /// information about multi-Region keys, see [Using multi-Region
    /// keys](https://docs.aws.amazon.com/kms/latest/developerguide/multi-region-keys-overview.html) in the *Key Management Service Developer Guide*.
    ///
    /// Examples:
    ///
    /// * `alias/MyAliasName`
    ///
    /// * `arn:aws:kms:us-east-2:123456789012:alias/MyAliasName`
    ///
    /// *
    ///   `arn:aws:kms:us-east-2:123456789012:key/12345678-1234-1234-1234-123456789012`
    ///
    /// * `12345678-1234-1234-1234-123456789012`
    kms_key_id: ?[]const u8 = null,

    /// Specifies the name of the trail. The name must meet the following
    /// requirements:
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
    name: []const u8,

    /// Specifies the name of the Amazon S3 bucket designated for publishing log
    /// files.
    /// For information about bucket naming rules, see [Bucket naming
    /// rules](https://docs.aws.amazon.com/AmazonS3/latest/userguide/bucketnamingrules.html)
    /// in the *Amazon Simple Storage Service User Guide*.
    s3_bucket_name: []const u8,

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

    tags_list: ?[]const Tag = null,

    pub const json_field_names = .{
        .cloud_watch_logs_log_group_arn = "CloudWatchLogsLogGroupArn",
        .cloud_watch_logs_role_arn = "CloudWatchLogsRoleArn",
        .enable_log_file_validation = "EnableLogFileValidation",
        .include_global_service_events = "IncludeGlobalServiceEvents",
        .is_multi_region_trail = "IsMultiRegionTrail",
        .is_organization_trail = "IsOrganizationTrail",
        .kms_key_id = "KmsKeyId",
        .name = "Name",
        .s3_bucket_name = "S3BucketName",
        .s3_key_prefix = "S3KeyPrefix",
        .sns_topic_name = "SnsTopicName",
        .tags_list = "TagsList",
    };
};

pub const CreateTrailOutput = struct {
    /// Specifies the Amazon Resource Name (ARN) of the log group to which
    /// CloudTrail
    /// logs will be delivered.
    cloud_watch_logs_log_group_arn: ?[]const u8 = null,

    /// Specifies the role for the CloudWatch Logs endpoint to assume to write to a
    /// user's
    /// log group.
    cloud_watch_logs_role_arn: ?[]const u8 = null,

    /// Specifies whether the trail is publishing events from global services such
    /// as IAM to the
    /// log files.
    include_global_service_events: ?bool = null,

    /// Specifies whether the trail exists in one Region or in all Regions.
    is_multi_region_trail: ?bool = null,

    /// Specifies whether the trail is an organization trail.
    is_organization_trail: ?bool = null,

    /// Specifies the KMS key ID that encrypts the events delivered by CloudTrail.
    /// The value is a fully specified ARN to a KMS key in the
    /// following format.
    ///
    /// `arn:aws:kms:us-east-2:123456789012:key/12345678-1234-1234-1234-123456789012`
    kms_key_id: ?[]const u8 = null,

    /// Specifies whether log file integrity validation is enabled.
    log_file_validation_enabled: ?bool = null,

    /// Specifies the name of the trail.
    name: ?[]const u8 = null,

    /// Specifies the name of the Amazon S3 bucket designated for publishing log
    /// files.
    s3_bucket_name: ?[]const u8 = null,

    /// Specifies the Amazon S3 key prefix that comes after the name of the bucket
    /// you
    /// have designated for log file delivery. For more information, see [Finding
    /// Your CloudTrail Log
    /// Files](https://docs.aws.amazon.com/awscloudtrail/latest/userguide/get-and-view-cloudtrail-log-files.html#cloudtrail-find-log-files).
    s3_key_prefix: ?[]const u8 = null,

    /// Specifies the ARN of the Amazon SNS topic that CloudTrail uses to send
    /// notifications when log files are delivered. The format of a topic ARN is:
    ///
    /// `arn:aws:sns:us-east-2:123456789012:MyTopic`
    sns_topic_arn: ?[]const u8 = null,

    /// This field is no longer in use. Use `SnsTopicARN`.
    sns_topic_name: ?[]const u8 = null,

    /// Specifies the ARN of the trail that was created. The format of a trail ARN
    /// is:
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
        .s3_bucket_name = "S3BucketName",
        .s3_key_prefix = "S3KeyPrefix",
        .sns_topic_arn = "SnsTopicARN",
        .sns_topic_name = "SnsTopicName",
        .trail_arn = "TrailARN",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateTrailInput, options: CallOptions) !CreateTrailOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "cloudtrail");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: CreateTrailInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cloudtrail", "CloudTrail", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "CloudTrail_20131101.CreateTrail");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateTrailOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateTrailOutput, body, allocator);
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "AccessDeniedException")) {
        return .{ .arena = arena, .kind = .{ .access_denied_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "AccountHasOngoingImportException")) {
        return .{ .arena = arena, .kind = .{ .account_has_ongoing_import_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "AccountNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .account_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "AccountNotRegisteredException")) {
        return .{ .arena = arena, .kind = .{ .account_not_registered_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "AccountRegisteredException")) {
        return .{ .arena = arena, .kind = .{ .account_registered_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CannotDelegateManagementAccountException")) {
        return .{ .arena = arena, .kind = .{ .cannot_delegate_management_account_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ChannelAlreadyExistsException")) {
        return .{ .arena = arena, .kind = .{ .channel_already_exists_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ChannelARNInvalidException")) {
        return .{ .arena = arena, .kind = .{ .channel_arn_invalid_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ChannelExistsForEDSException")) {
        return .{ .arena = arena, .kind = .{ .channel_exists_for_eds_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ChannelMaxLimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .channel_max_limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ChannelNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .channel_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CloudTrailAccessNotEnabledException")) {
        return .{ .arena = arena, .kind = .{ .cloud_trail_access_not_enabled_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CloudTrailARNInvalidException")) {
        return .{ .arena = arena, .kind = .{ .cloud_trail_arn_invalid_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CloudTrailInvalidClientTokenIdException")) {
        return .{ .arena = arena, .kind = .{ .cloud_trail_invalid_client_token_id_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CloudWatchLogsDeliveryUnavailableException")) {
        return .{ .arena = arena, .kind = .{ .cloud_watch_logs_delivery_unavailable_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConcurrentModificationException")) {
        return .{ .arena = arena, .kind = .{ .concurrent_modification_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DelegatedAdminAccountLimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .delegated_admin_account_limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "EventDataStoreAlreadyExistsException")) {
        return .{ .arena = arena, .kind = .{ .event_data_store_already_exists_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "EventDataStoreARNInvalidException")) {
        return .{ .arena = arena, .kind = .{ .event_data_store_arn_invalid_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "EventDataStoreFederationEnabledException")) {
        return .{ .arena = arena, .kind = .{ .event_data_store_federation_enabled_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "EventDataStoreHasOngoingImportException")) {
        return .{ .arena = arena, .kind = .{ .event_data_store_has_ongoing_import_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "EventDataStoreMaxLimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .event_data_store_max_limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "EventDataStoreNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .event_data_store_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "EventDataStoreTerminationProtectedException")) {
        return .{ .arena = arena, .kind = .{ .event_data_store_termination_protected_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "GenerateResponseException")) {
        return .{ .arena = arena, .kind = .{ .generate_response_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ImportNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .import_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InactiveEventDataStoreException")) {
        return .{ .arena = arena, .kind = .{ .inactive_event_data_store_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InactiveQueryException")) {
        return .{ .arena = arena, .kind = .{ .inactive_query_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InsightNotEnabledException")) {
        return .{ .arena = arena, .kind = .{ .insight_not_enabled_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InsufficientDependencyServiceAccessPermissionException")) {
        return .{ .arena = arena, .kind = .{ .insufficient_dependency_service_access_permission_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InsufficientEncryptionPolicyException")) {
        return .{ .arena = arena, .kind = .{ .insufficient_encryption_policy_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InsufficientIAMAccessPermissionException")) {
        return .{ .arena = arena, .kind = .{ .insufficient_iam_access_permission_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InsufficientS3BucketPolicyException")) {
        return .{ .arena = arena, .kind = .{ .insufficient_s3_bucket_policy_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InsufficientSnsTopicPolicyException")) {
        return .{ .arena = arena, .kind = .{ .insufficient_sns_topic_policy_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidCloudWatchLogsLogGroupArnException")) {
        return .{ .arena = arena, .kind = .{ .invalid_cloud_watch_logs_log_group_arn_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidCloudWatchLogsRoleArnException")) {
        return .{ .arena = arena, .kind = .{ .invalid_cloud_watch_logs_role_arn_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidDateRangeException")) {
        return .{ .arena = arena, .kind = .{ .invalid_date_range_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidEventCategoryException")) {
        return .{ .arena = arena, .kind = .{ .invalid_event_category_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidEventDataStoreCategoryException")) {
        return .{ .arena = arena, .kind = .{ .invalid_event_data_store_category_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidEventDataStoreStatusException")) {
        return .{ .arena = arena, .kind = .{ .invalid_event_data_store_status_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidEventSelectorsException")) {
        return .{ .arena = arena, .kind = .{ .invalid_event_selectors_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidHomeRegionException")) {
        return .{ .arena = arena, .kind = .{ .invalid_home_region_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidImportSourceException")) {
        return .{ .arena = arena, .kind = .{ .invalid_import_source_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidInsightSelectorsException")) {
        return .{ .arena = arena, .kind = .{ .invalid_insight_selectors_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidKmsKeyIdException")) {
        return .{ .arena = arena, .kind = .{ .invalid_kms_key_id_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidLookupAttributesException")) {
        return .{ .arena = arena, .kind = .{ .invalid_lookup_attributes_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidMaxResultsException")) {
        return .{ .arena = arena, .kind = .{ .invalid_max_results_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidNextTokenException")) {
        return .{ .arena = arena, .kind = .{ .invalid_next_token_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidParameterCombinationException")) {
        return .{ .arena = arena, .kind = .{ .invalid_parameter_combination_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidParameterException")) {
        return .{ .arena = arena, .kind = .{ .invalid_parameter_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidQueryStatementException")) {
        return .{ .arena = arena, .kind = .{ .invalid_query_statement_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidQueryStatusException")) {
        return .{ .arena = arena, .kind = .{ .invalid_query_status_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidS3BucketNameException")) {
        return .{ .arena = arena, .kind = .{ .invalid_s3_bucket_name_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidS3PrefixException")) {
        return .{ .arena = arena, .kind = .{ .invalid_s3_prefix_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidSnsTopicNameException")) {
        return .{ .arena = arena, .kind = .{ .invalid_sns_topic_name_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidSourceException")) {
        return .{ .arena = arena, .kind = .{ .invalid_source_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidTagParameterException")) {
        return .{ .arena = arena, .kind = .{ .invalid_tag_parameter_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidTimeRangeException")) {
        return .{ .arena = arena, .kind = .{ .invalid_time_range_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidTokenException")) {
        return .{ .arena = arena, .kind = .{ .invalid_token_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidTrailNameException")) {
        return .{ .arena = arena, .kind = .{ .invalid_trail_name_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "KmsException")) {
        return .{ .arena = arena, .kind = .{ .kms_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "KmsKeyDisabledException")) {
        return .{ .arena = arena, .kind = .{ .kms_key_disabled_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "KmsKeyNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .kms_key_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "MaxConcurrentQueriesException")) {
        return .{ .arena = arena, .kind = .{ .max_concurrent_queries_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "MaximumNumberOfTrailsExceededException")) {
        return .{ .arena = arena, .kind = .{ .maximum_number_of_trails_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NoManagementAccountSLRExistsException")) {
        return .{ .arena = arena, .kind = .{ .no_management_account_slr_exists_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NotOrganizationManagementAccountException")) {
        return .{ .arena = arena, .kind = .{ .not_organization_management_account_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NotOrganizationMasterAccountException")) {
        return .{ .arena = arena, .kind = .{ .not_organization_master_account_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "OperationNotPermittedException")) {
        return .{ .arena = arena, .kind = .{ .operation_not_permitted_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "OrganizationNotInAllFeaturesModeException")) {
        return .{ .arena = arena, .kind = .{ .organization_not_in_all_features_mode_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "OrganizationsNotInUseException")) {
        return .{ .arena = arena, .kind = .{ .organizations_not_in_use_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "QueryIdNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .query_id_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceARNNotValidException")) {
        return .{ .arena = arena, .kind = .{ .resource_arn_not_valid_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourcePolicyNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_policy_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourcePolicyNotValidException")) {
        return .{ .arena = arena, .kind = .{ .resource_policy_not_valid_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceTypeNotSupportedException")) {
        return .{ .arena = arena, .kind = .{ .resource_type_not_supported_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "S3BucketDoesNotExistException")) {
        return .{ .arena = arena, .kind = .{ .s3_bucket_does_not_exist_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceQuotaExceededException")) {
        return .{ .arena = arena, .kind = .{ .service_quota_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TagsLimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .tags_limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ThrottlingException")) {
        return .{ .arena = arena, .kind = .{ .throttling_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TrailAlreadyExistsException")) {
        return .{ .arena = arena, .kind = .{ .trail_already_exists_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TrailNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .trail_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TrailNotProvidedException")) {
        return .{ .arena = arena, .kind = .{ .trail_not_provided_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnsupportedOperationException")) {
        return .{ .arena = arena, .kind = .{ .unsupported_operation_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
