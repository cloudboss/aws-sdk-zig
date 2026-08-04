const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const errors = @import("errors.zig");
const ServiceError = errors.ServiceError;
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
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "cloudtrail", client.config.http_client.clock_skew_offset);

    var response = try client.config.http_client.sendRequestWithOptions(&request, client.options);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch return error.OutOfMemory;
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: CreateTrailInput, config: *aws.Config) !aws.http.Request {
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
        if (std.mem.findScalarLast(u8, type_str, '#')) |idx| {
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
        const parsed_error: ?errors.AccessDeniedException = aws.json.parseJsonObject(errors.AccessDeniedException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .access_denied_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "AccountHasOngoingImportException")) {
        const parsed_error: ?errors.AccountHasOngoingImportException = aws.json.parseJsonObject(errors.AccountHasOngoingImportException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .account_has_ongoing_import_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "AccountNotFoundException")) {
        const parsed_error: ?errors.AccountNotFoundException = aws.json.parseJsonObject(errors.AccountNotFoundException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .account_not_found_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "AccountNotRegisteredException")) {
        const parsed_error: ?errors.AccountNotRegisteredException = aws.json.parseJsonObject(errors.AccountNotRegisteredException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .account_not_registered_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "AccountRegisteredException")) {
        const parsed_error: ?errors.AccountRegisteredException = aws.json.parseJsonObject(errors.AccountRegisteredException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .account_registered_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "CannotDelegateManagementAccountException")) {
        const parsed_error: ?errors.CannotDelegateManagementAccountException = aws.json.parseJsonObject(errors.CannotDelegateManagementAccountException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .cannot_delegate_management_account_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ChannelAlreadyExistsException")) {
        const parsed_error: ?errors.ChannelAlreadyExistsException = aws.json.parseJsonObject(errors.ChannelAlreadyExistsException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .channel_already_exists_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ChannelARNInvalidException")) {
        const parsed_error: ?errors.ChannelARNInvalidException = aws.json.parseJsonObject(errors.ChannelARNInvalidException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .channel_arn_invalid_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ChannelExistsForEDSException")) {
        const parsed_error: ?errors.ChannelExistsForEDSException = aws.json.parseJsonObject(errors.ChannelExistsForEDSException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .channel_exists_for_eds_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ChannelMaxLimitExceededException")) {
        const parsed_error: ?errors.ChannelMaxLimitExceededException = aws.json.parseJsonObject(errors.ChannelMaxLimitExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .channel_max_limit_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ChannelNotFoundException")) {
        const parsed_error: ?errors.ChannelNotFoundException = aws.json.parseJsonObject(errors.ChannelNotFoundException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .channel_not_found_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "CloudTrailAccessNotEnabledException")) {
        const parsed_error: ?errors.CloudTrailAccessNotEnabledException = aws.json.parseJsonObject(errors.CloudTrailAccessNotEnabledException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .cloud_trail_access_not_enabled_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "CloudTrailARNInvalidException")) {
        const parsed_error: ?errors.CloudTrailARNInvalidException = aws.json.parseJsonObject(errors.CloudTrailARNInvalidException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .cloud_trail_arn_invalid_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "CloudTrailInvalidClientTokenIdException")) {
        const parsed_error: ?errors.CloudTrailInvalidClientTokenIdException = aws.json.parseJsonObject(errors.CloudTrailInvalidClientTokenIdException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .cloud_trail_invalid_client_token_id_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "CloudWatchLogsDeliveryUnavailableException")) {
        const parsed_error: ?errors.CloudWatchLogsDeliveryUnavailableException = aws.json.parseJsonObject(errors.CloudWatchLogsDeliveryUnavailableException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .cloud_watch_logs_delivery_unavailable_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ConcurrentModificationException")) {
        const parsed_error: ?errors.ConcurrentModificationException = aws.json.parseJsonObject(errors.ConcurrentModificationException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .concurrent_modification_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ConflictException")) {
        const parsed_error: ?errors.ConflictException = aws.json.parseJsonObject(errors.ConflictException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .conflict_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "DelegatedAdminAccountLimitExceededException")) {
        const parsed_error: ?errors.DelegatedAdminAccountLimitExceededException = aws.json.parseJsonObject(errors.DelegatedAdminAccountLimitExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .delegated_admin_account_limit_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "EventDataStoreAlreadyExistsException")) {
        const parsed_error: ?errors.EventDataStoreAlreadyExistsException = aws.json.parseJsonObject(errors.EventDataStoreAlreadyExistsException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .event_data_store_already_exists_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "EventDataStoreARNInvalidException")) {
        const parsed_error: ?errors.EventDataStoreARNInvalidException = aws.json.parseJsonObject(errors.EventDataStoreARNInvalidException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .event_data_store_arn_invalid_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "EventDataStoreFederationEnabledException")) {
        const parsed_error: ?errors.EventDataStoreFederationEnabledException = aws.json.parseJsonObject(errors.EventDataStoreFederationEnabledException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .event_data_store_federation_enabled_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "EventDataStoreHasOngoingImportException")) {
        const parsed_error: ?errors.EventDataStoreHasOngoingImportException = aws.json.parseJsonObject(errors.EventDataStoreHasOngoingImportException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .event_data_store_has_ongoing_import_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "EventDataStoreMaxLimitExceededException")) {
        const parsed_error: ?errors.EventDataStoreMaxLimitExceededException = aws.json.parseJsonObject(errors.EventDataStoreMaxLimitExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .event_data_store_max_limit_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "EventDataStoreNotFoundException")) {
        const parsed_error: ?errors.EventDataStoreNotFoundException = aws.json.parseJsonObject(errors.EventDataStoreNotFoundException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .event_data_store_not_found_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "EventDataStoreTerminationProtectedException")) {
        const parsed_error: ?errors.EventDataStoreTerminationProtectedException = aws.json.parseJsonObject(errors.EventDataStoreTerminationProtectedException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .event_data_store_termination_protected_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "GenerateResponseException")) {
        const parsed_error: ?errors.GenerateResponseException = aws.json.parseJsonObject(errors.GenerateResponseException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .generate_response_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ImportNotFoundException")) {
        const parsed_error: ?errors.ImportNotFoundException = aws.json.parseJsonObject(errors.ImportNotFoundException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .import_not_found_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InactiveEventDataStoreException")) {
        const parsed_error: ?errors.InactiveEventDataStoreException = aws.json.parseJsonObject(errors.InactiveEventDataStoreException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .inactive_event_data_store_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InactiveQueryException")) {
        const parsed_error: ?errors.InactiveQueryException = aws.json.parseJsonObject(errors.InactiveQueryException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .inactive_query_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InsightNotEnabledException")) {
        const parsed_error: ?errors.InsightNotEnabledException = aws.json.parseJsonObject(errors.InsightNotEnabledException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .insight_not_enabled_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InsufficientDependencyServiceAccessPermissionException")) {
        const parsed_error: ?errors.InsufficientDependencyServiceAccessPermissionException = aws.json.parseJsonObject(errors.InsufficientDependencyServiceAccessPermissionException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .insufficient_dependency_service_access_permission_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InsufficientEncryptionPolicyException")) {
        const parsed_error: ?errors.InsufficientEncryptionPolicyException = aws.json.parseJsonObject(errors.InsufficientEncryptionPolicyException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .insufficient_encryption_policy_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InsufficientIAMAccessPermissionException")) {
        const parsed_error: ?errors.InsufficientIAMAccessPermissionException = aws.json.parseJsonObject(errors.InsufficientIAMAccessPermissionException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .insufficient_iam_access_permission_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InsufficientS3BucketPolicyException")) {
        const parsed_error: ?errors.InsufficientS3BucketPolicyException = aws.json.parseJsonObject(errors.InsufficientS3BucketPolicyException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .insufficient_s3_bucket_policy_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InsufficientSnsTopicPolicyException")) {
        const parsed_error: ?errors.InsufficientSnsTopicPolicyException = aws.json.parseJsonObject(errors.InsufficientSnsTopicPolicyException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .insufficient_sns_topic_policy_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidCloudWatchLogsLogGroupArnException")) {
        const parsed_error: ?errors.InvalidCloudWatchLogsLogGroupArnException = aws.json.parseJsonObject(errors.InvalidCloudWatchLogsLogGroupArnException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_cloud_watch_logs_log_group_arn_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidCloudWatchLogsRoleArnException")) {
        const parsed_error: ?errors.InvalidCloudWatchLogsRoleArnException = aws.json.parseJsonObject(errors.InvalidCloudWatchLogsRoleArnException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_cloud_watch_logs_role_arn_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidDateRangeException")) {
        const parsed_error: ?errors.InvalidDateRangeException = aws.json.parseJsonObject(errors.InvalidDateRangeException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_date_range_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidEventCategoryException")) {
        const parsed_error: ?errors.InvalidEventCategoryException = aws.json.parseJsonObject(errors.InvalidEventCategoryException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_event_category_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidEventDataStoreCategoryException")) {
        const parsed_error: ?errors.InvalidEventDataStoreCategoryException = aws.json.parseJsonObject(errors.InvalidEventDataStoreCategoryException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_event_data_store_category_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidEventDataStoreStatusException")) {
        const parsed_error: ?errors.InvalidEventDataStoreStatusException = aws.json.parseJsonObject(errors.InvalidEventDataStoreStatusException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_event_data_store_status_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidEventSelectorsException")) {
        const parsed_error: ?errors.InvalidEventSelectorsException = aws.json.parseJsonObject(errors.InvalidEventSelectorsException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_event_selectors_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidHomeRegionException")) {
        const parsed_error: ?errors.InvalidHomeRegionException = aws.json.parseJsonObject(errors.InvalidHomeRegionException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_home_region_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidImportSourceException")) {
        const parsed_error: ?errors.InvalidImportSourceException = aws.json.parseJsonObject(errors.InvalidImportSourceException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_import_source_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidInsightSelectorsException")) {
        const parsed_error: ?errors.InvalidInsightSelectorsException = aws.json.parseJsonObject(errors.InvalidInsightSelectorsException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_insight_selectors_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidKmsKeyIdException")) {
        const parsed_error: ?errors.InvalidKmsKeyIdException = aws.json.parseJsonObject(errors.InvalidKmsKeyIdException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_kms_key_id_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidLookupAttributesException")) {
        const parsed_error: ?errors.InvalidLookupAttributesException = aws.json.parseJsonObject(errors.InvalidLookupAttributesException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_lookup_attributes_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidMaxResultsException")) {
        const parsed_error: ?errors.InvalidMaxResultsException = aws.json.parseJsonObject(errors.InvalidMaxResultsException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_max_results_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidNextTokenException")) {
        const parsed_error: ?errors.InvalidNextTokenException = aws.json.parseJsonObject(errors.InvalidNextTokenException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_next_token_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidParameterCombinationException")) {
        const parsed_error: ?errors.InvalidParameterCombinationException = aws.json.parseJsonObject(errors.InvalidParameterCombinationException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_parameter_combination_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidParameterException")) {
        const parsed_error: ?errors.InvalidParameterException = aws.json.parseJsonObject(errors.InvalidParameterException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_parameter_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidQueryStatementException")) {
        const parsed_error: ?errors.InvalidQueryStatementException = aws.json.parseJsonObject(errors.InvalidQueryStatementException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_query_statement_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidQueryStatusException")) {
        const parsed_error: ?errors.InvalidQueryStatusException = aws.json.parseJsonObject(errors.InvalidQueryStatusException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_query_status_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidS3BucketNameException")) {
        const parsed_error: ?errors.InvalidS3BucketNameException = aws.json.parseJsonObject(errors.InvalidS3BucketNameException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_s3_bucket_name_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidS3PrefixException")) {
        const parsed_error: ?errors.InvalidS3PrefixException = aws.json.parseJsonObject(errors.InvalidS3PrefixException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_s3_prefix_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidSnsTopicNameException")) {
        const parsed_error: ?errors.InvalidSnsTopicNameException = aws.json.parseJsonObject(errors.InvalidSnsTopicNameException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_sns_topic_name_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidSourceException")) {
        const parsed_error: ?errors.InvalidSourceException = aws.json.parseJsonObject(errors.InvalidSourceException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_source_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidTagParameterException")) {
        const parsed_error: ?errors.InvalidTagParameterException = aws.json.parseJsonObject(errors.InvalidTagParameterException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_tag_parameter_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidTimeRangeException")) {
        const parsed_error: ?errors.InvalidTimeRangeException = aws.json.parseJsonObject(errors.InvalidTimeRangeException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_time_range_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidTokenException")) {
        const parsed_error: ?errors.InvalidTokenException = aws.json.parseJsonObject(errors.InvalidTokenException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_token_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidTrailNameException")) {
        const parsed_error: ?errors.InvalidTrailNameException = aws.json.parseJsonObject(errors.InvalidTrailNameException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_trail_name_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "KmsException")) {
        const parsed_error: ?errors.KmsException = aws.json.parseJsonObject(errors.KmsException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .kms_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "KmsKeyDisabledException")) {
        const parsed_error: ?errors.KmsKeyDisabledException = aws.json.parseJsonObject(errors.KmsKeyDisabledException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .kms_key_disabled_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "KmsKeyNotFoundException")) {
        const parsed_error: ?errors.KmsKeyNotFoundException = aws.json.parseJsonObject(errors.KmsKeyNotFoundException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .kms_key_not_found_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "MaxConcurrentQueriesException")) {
        const parsed_error: ?errors.MaxConcurrentQueriesException = aws.json.parseJsonObject(errors.MaxConcurrentQueriesException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .max_concurrent_queries_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "MaximumNumberOfTrailsExceededException")) {
        const parsed_error: ?errors.MaximumNumberOfTrailsExceededException = aws.json.parseJsonObject(errors.MaximumNumberOfTrailsExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .maximum_number_of_trails_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "NoManagementAccountSLRExistsException")) {
        const parsed_error: ?errors.NoManagementAccountSLRExistsException = aws.json.parseJsonObject(errors.NoManagementAccountSLRExistsException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .no_management_account_slr_exists_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "NotOrganizationManagementAccountException")) {
        const parsed_error: ?errors.NotOrganizationManagementAccountException = aws.json.parseJsonObject(errors.NotOrganizationManagementAccountException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .not_organization_management_account_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "NotOrganizationMasterAccountException")) {
        const parsed_error: ?errors.NotOrganizationMasterAccountException = aws.json.parseJsonObject(errors.NotOrganizationMasterAccountException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .not_organization_master_account_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "OperationNotPermittedException")) {
        const parsed_error: ?errors.OperationNotPermittedException = aws.json.parseJsonObject(errors.OperationNotPermittedException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .operation_not_permitted_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "OrganizationNotInAllFeaturesModeException")) {
        const parsed_error: ?errors.OrganizationNotInAllFeaturesModeException = aws.json.parseJsonObject(errors.OrganizationNotInAllFeaturesModeException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .organization_not_in_all_features_mode_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "OrganizationsNotInUseException")) {
        const parsed_error: ?errors.OrganizationsNotInUseException = aws.json.parseJsonObject(errors.OrganizationsNotInUseException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .organizations_not_in_use_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "QueryIdNotFoundException")) {
        const parsed_error: ?errors.QueryIdNotFoundException = aws.json.parseJsonObject(errors.QueryIdNotFoundException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .query_id_not_found_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ResourceARNNotValidException")) {
        const parsed_error: ?errors.ResourceARNNotValidException = aws.json.parseJsonObject(errors.ResourceARNNotValidException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .resource_arn_not_valid_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        const parsed_error: ?errors.ResourceNotFoundException = aws.json.parseJsonObject(errors.ResourceNotFoundException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .resource_not_found_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ResourcePolicyNotFoundException")) {
        const parsed_error: ?errors.ResourcePolicyNotFoundException = aws.json.parseJsonObject(errors.ResourcePolicyNotFoundException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .resource_policy_not_found_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ResourcePolicyNotValidException")) {
        const parsed_error: ?errors.ResourcePolicyNotValidException = aws.json.parseJsonObject(errors.ResourcePolicyNotValidException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .resource_policy_not_valid_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ResourceTypeNotSupportedException")) {
        const parsed_error: ?errors.ResourceTypeNotSupportedException = aws.json.parseJsonObject(errors.ResourceTypeNotSupportedException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .resource_type_not_supported_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "S3BucketDoesNotExistException")) {
        const parsed_error: ?errors.S3BucketDoesNotExistException = aws.json.parseJsonObject(errors.S3BucketDoesNotExistException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .s3_bucket_does_not_exist_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ServiceQuotaExceededException")) {
        const parsed_error: ?errors.ServiceQuotaExceededException = aws.json.parseJsonObject(errors.ServiceQuotaExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .service_quota_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "TagsLimitExceededException")) {
        const parsed_error: ?errors.TagsLimitExceededException = aws.json.parseJsonObject(errors.TagsLimitExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .tags_limit_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ThrottlingException")) {
        const parsed_error: ?errors.ThrottlingException = aws.json.parseJsonObject(errors.ThrottlingException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .throttling_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "TrailAlreadyExistsException")) {
        const parsed_error: ?errors.TrailAlreadyExistsException = aws.json.parseJsonObject(errors.TrailAlreadyExistsException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .trail_already_exists_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "TrailNotFoundException")) {
        const parsed_error: ?errors.TrailNotFoundException = aws.json.parseJsonObject(errors.TrailNotFoundException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .trail_not_found_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "TrailNotProvidedException")) {
        const parsed_error: ?errors.TrailNotProvidedException = aws.json.parseJsonObject(errors.TrailNotProvidedException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .trail_not_provided_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "UnsupportedOperationException")) {
        const parsed_error: ?errors.UnsupportedOperationException = aws.json.parseJsonObject(errors.UnsupportedOperationException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .unsupported_operation_exception = typed_error } };
        }
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
