const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const AdvancedEventSelector = @import("advanced_event_selector.zig").AdvancedEventSelector;
const BillingMode = @import("billing_mode.zig").BillingMode;
const FederationStatus = @import("federation_status.zig").FederationStatus;
const EventDataStoreStatus = @import("event_data_store_status.zig").EventDataStoreStatus;

pub const UpdateEventDataStoreInput = struct {
    /// The advanced event selectors used to select events for the event data store.
    /// You can
    /// configure up to five advanced event selectors for each event data store.
    advanced_event_selectors: ?[]const AdvancedEventSelector = null,

    /// You can't change the billing mode from `EXTENDABLE_RETENTION_PRICING` to
    /// `FIXED_RETENTION_PRICING`. If `BillingMode` is set to
    /// `EXTENDABLE_RETENTION_PRICING` and you want to use `FIXED_RETENTION_PRICING`
    /// instead, you'll need to stop ingestion on the event data store and create a
    /// new event data store that uses `FIXED_RETENTION_PRICING`.
    ///
    /// The billing mode for the event data store determines the cost
    /// for ingesting events and the default and maximum retention period for the
    /// event data store.
    ///
    /// The following are the possible values:
    ///
    /// * `EXTENDABLE_RETENTION_PRICING` - This billing mode is generally
    ///   recommended if you want a flexible retention period of up to 3653 days
    ///   (about 10 years). The default retention period for this billing mode is
    /// 366 days.
    ///
    /// * `FIXED_RETENTION_PRICING` - This billing mode is recommended if you expect
    ///   to ingest more than 25 TB of event data per month and need a retention
    ///   period of up to 2557 days (about 7 years).
    /// The default retention period for this billing mode is 2557 days.
    ///
    /// For more information about CloudTrail pricing,
    /// see [CloudTrail Pricing](http://aws.amazon.com/cloudtrail/pricing/) and
    /// [Managing CloudTrail Lake
    /// costs](https://docs.aws.amazon.com/awscloudtrail/latest/userguide/cloudtrail-lake-manage-costs.html).
    billing_mode: ?BillingMode = null,

    /// The ARN (or the ID suffix of the ARN) of the event data store that you want
    /// to
    /// update.
    event_data_store: []const u8,

    /// Specifies the KMS key ID to use to encrypt the events delivered by
    /// CloudTrail. The value can be an alias name prefixed by `alias/`, a
    /// fully specified ARN to an alias, a fully specified ARN to a key, or a
    /// globally unique
    /// identifier.
    ///
    /// Disabling or deleting the KMS key, or removing CloudTrail
    /// permissions on the key, prevents CloudTrail from logging events to the event
    /// data
    /// store, and prevents users from querying the data in the event data store
    /// that was
    /// encrypted with the key. After you associate an event data store with a KMS
    /// key, the KMS key cannot be removed or changed. Before you
    /// disable or delete a KMS key that you are using with an event data store,
    /// delete or back up your event data store.
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

    /// Specifies whether an event data store collects events from all Regions, or
    /// only from the
    /// Region in which it was created.
    multi_region_enabled: ?bool = null,

    /// The event data store name.
    name: ?[]const u8 = null,

    /// Specifies whether an event data store collects events logged for an
    /// organization in
    /// Organizations.
    ///
    /// Only the management account for the organization can convert an organization
    /// event data store to a non-organization event data store, or convert a
    /// non-organization event data store to
    /// an organization event data store.
    organization_enabled: ?bool = null,

    /// The retention period of the event data store, in days. If `BillingMode` is
    /// set to `EXTENDABLE_RETENTION_PRICING`, you can set a retention period of
    /// up to 3653 days, the equivalent of 10 years. If `BillingMode` is set to
    /// `FIXED_RETENTION_PRICING`, you can set a retention period of
    /// up to 2557 days, the equivalent of seven years.
    ///
    /// CloudTrail Lake determines whether to retain an event by checking if the
    /// `eventTime`
    /// of the event is within the specified retention period. For example, if you
    /// set a retention period of 90 days, CloudTrail will remove events
    /// when the `eventTime` is older than 90 days.
    ///
    /// If you decrease the retention period of an event data store, CloudTrail will
    /// remove any events with an `eventTime` older than the new retention period.
    /// For example, if the previous
    /// retention period was 365 days and you decrease it to 100 days, CloudTrail
    /// will remove events with an `eventTime` older than 100 days.
    retention_period: ?i32 = null,

    /// Indicates that termination protection is enabled and the event data store
    /// cannot be
    /// automatically deleted.
    termination_protection_enabled: ?bool = null,

    pub const json_field_names = .{
        .advanced_event_selectors = "AdvancedEventSelectors",
        .billing_mode = "BillingMode",
        .event_data_store = "EventDataStore",
        .kms_key_id = "KmsKeyId",
        .multi_region_enabled = "MultiRegionEnabled",
        .name = "Name",
        .organization_enabled = "OrganizationEnabled",
        .retention_period = "RetentionPeriod",
        .termination_protection_enabled = "TerminationProtectionEnabled",
    };
};

pub const UpdateEventDataStoreOutput = struct {
    /// The advanced event selectors that are applied to the event data store.
    advanced_event_selectors: ?[]const AdvancedEventSelector = null,

    /// The billing mode for the event data store.
    billing_mode: ?BillingMode = null,

    /// The timestamp that shows when an event data store was first created.
    created_timestamp: ?i64 = null,

    /// The ARN of the event data store.
    event_data_store_arn: ?[]const u8 = null,

    /// If Lake query federation is enabled, provides the ARN of the federation role
    /// used to access the resources for the federated event data store.
    federation_role_arn: ?[]const u8 = null,

    /// Indicates the [Lake query
    /// federation](https://docs.aws.amazon.com/awscloudtrail/latest/userguide/query-federation.html) status. The status is
    /// `ENABLED` if Lake query federation is enabled, or `DISABLED` if Lake query
    /// federation is disabled. You cannot delete an event data store if the
    /// `FederationStatus` is `ENABLED`.
    federation_status: ?FederationStatus = null,

    /// Specifies the KMS key ID that encrypts the events delivered by CloudTrail.
    /// The value is a fully specified ARN to a KMS key in the
    /// following format.
    ///
    /// `arn:aws:kms:us-east-2:123456789012:key/12345678-1234-1234-1234-123456789012`
    kms_key_id: ?[]const u8 = null,

    /// Indicates whether the event data store includes events from all Regions, or
    /// only from
    /// the Region in which it was created.
    multi_region_enabled: ?bool = null,

    /// The name of the event data store.
    name: ?[]const u8 = null,

    /// Indicates whether an event data store is collecting logged events for an
    /// organization in
    /// Organizations.
    organization_enabled: ?bool = null,

    /// The retention period, in days.
    retention_period: ?i32 = null,

    /// The status of an event data store.
    status: ?EventDataStoreStatus = null,

    /// Indicates whether termination protection is enabled for the event data
    /// store.
    termination_protection_enabled: ?bool = null,

    /// The timestamp that shows when the event data store was last updated.
    /// `UpdatedTimestamp` is always either the same or newer than the time shown in
    /// `CreatedTimestamp`.
    updated_timestamp: ?i64 = null,

    pub const json_field_names = .{
        .advanced_event_selectors = "AdvancedEventSelectors",
        .billing_mode = "BillingMode",
        .created_timestamp = "CreatedTimestamp",
        .event_data_store_arn = "EventDataStoreArn",
        .federation_role_arn = "FederationRoleArn",
        .federation_status = "FederationStatus",
        .kms_key_id = "KmsKeyId",
        .multi_region_enabled = "MultiRegionEnabled",
        .name = "Name",
        .organization_enabled = "OrganizationEnabled",
        .retention_period = "RetentionPeriod",
        .status = "Status",
        .termination_protection_enabled = "TerminationProtectionEnabled",
        .updated_timestamp = "UpdatedTimestamp",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateEventDataStoreInput, options: CallOptions) !UpdateEventDataStoreOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateEventDataStoreInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "CloudTrail_20131101.UpdateEventDataStore");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateEventDataStoreOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateEventDataStoreOutput, body, allocator);
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
