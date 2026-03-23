const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const InsightSelector = @import("insight_selector.zig").InsightSelector;

pub const PutInsightSelectorsInput = struct {
    /// The ARN (or ID suffix of the ARN) of the source event data store for which
    /// you want to change or add Insights
    /// selectors. To enable Insights on an event data store, you must provide both
    /// the
    /// `EventDataStore` and `InsightsDestination` parameters.
    ///
    /// You cannot use this parameter with the `TrailName` parameter.
    event_data_store: ?[]const u8 = null,

    /// The ARN (or ID suffix of the ARN) of the destination event data store that
    /// logs Insights events. To enable Insights on an event data store, you must
    /// provide both the
    /// `EventDataStore` and `InsightsDestination` parameters.
    ///
    /// You cannot use this parameter with the `TrailName` parameter.
    insights_destination: ?[]const u8 = null,

    /// Contains the Insights types you want to log on a specific category of events
    /// on a trail or event data store.
    /// `ApiCallRateInsight` and `ApiErrorRateInsight` are valid Insight
    /// types.The EventCategory field can specify `Management` or `Data` events or
    /// both. For event data store, you can log Insights for management events only.
    ///
    /// The `ApiCallRateInsight` Insights type analyzes write-only management
    /// API calls or read and write data API calls that are aggregated per minute
    /// against a baseline API call volume.
    ///
    /// The `ApiErrorRateInsight` Insights type analyzes management and data
    /// API calls that result in error codes. The error is shown if the API call is
    /// unsuccessful.
    insight_selectors: []const InsightSelector,

    /// The name of the CloudTrail trail for which you want to change or add
    /// Insights
    /// selectors.
    ///
    /// You cannot use this parameter with the `EventDataStore` and
    /// `InsightsDestination` parameters.
    trail_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .event_data_store = "EventDataStore",
        .insights_destination = "InsightsDestination",
        .insight_selectors = "InsightSelectors",
        .trail_name = "TrailName",
    };
};

pub const PutInsightSelectorsOutput = struct {
    /// The Amazon Resource Name (ARN) of the source event data store for which you
    /// want to change or add Insights
    /// selectors.
    event_data_store_arn: ?[]const u8 = null,

    /// The ARN of the destination event data store that logs Insights events.
    insights_destination: ?[]const u8 = null,

    /// Contains the Insights types you want to log on a specific category of events
    /// in a trail or event data store.
    /// `ApiCallRateInsight` and `ApiErrorRateInsight` are valid Insight
    /// types.The EventCategory field can specify `Management` or `Data` events or
    /// both. For event data store, you can only log Insights for management events
    /// only.
    insight_selectors: ?[]const InsightSelector = null,

    /// The Amazon Resource Name (ARN) of a trail for which you want to change or
    /// add Insights
    /// selectors.
    trail_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .event_data_store_arn = "EventDataStoreArn",
        .insights_destination = "InsightsDestination",
        .insight_selectors = "InsightSelectors",
        .trail_arn = "TrailARN",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutInsightSelectorsInput, options: CallOptions) !PutInsightSelectorsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: PutInsightSelectorsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "CloudTrail_20131101.PutInsightSelectors");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutInsightSelectorsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(PutInsightSelectorsOutput, body, allocator);
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
