const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const errors = @import("errors.zig");
const ServiceError = errors.ServiceError;
const StatusDetailFilters = @import("status_detail_filters.zig").StatusDetailFilters;
const MemberAccountStatus = @import("member_account_status.zig").MemberAccountStatus;

pub const GetOrganizationConfigRuleDetailedStatusInput = struct {
    /// A `StatusDetailFilters` object.
    filters: ?StatusDetailFilters = null,

    /// The maximum number of `OrganizationConfigRuleDetailedStatus` returned on
    /// each page. If you do not specify a number, Config uses the default. The
    /// default is 100.
    limit: ?i32 = null,

    /// The `nextToken` string returned on a previous page that you use to get the
    /// next page of results in a paginated response.
    next_token: ?[]const u8 = null,

    /// The name of your organization Config rule for which you want status details
    /// for member accounts.
    organization_config_rule_name: []const u8,

    pub const json_field_names = .{
        .filters = "Filters",
        .limit = "Limit",
        .next_token = "NextToken",
        .organization_config_rule_name = "OrganizationConfigRuleName",
    };
};

pub const GetOrganizationConfigRuleDetailedStatusOutput = struct {
    /// The `nextToken` string returned on a previous page that you use to get the
    /// next page of results in a paginated response.
    next_token: ?[]const u8 = null,

    /// A list of `MemberAccountStatus` objects.
    organization_config_rule_detailed_status: ?[]const MemberAccountStatus = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .organization_config_rule_detailed_status = "OrganizationConfigRuleDetailedStatus",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetOrganizationConfigRuleDetailedStatusInput, options: CallOptions) !GetOrganizationConfigRuleDetailedStatusOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "config", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetOrganizationConfigRuleDetailedStatusInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("config", "Config Service", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "StarlingDoveService.GetOrganizationConfigRuleDetailedStatus");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetOrganizationConfigRuleDetailedStatusOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetOrganizationConfigRuleDetailedStatusOutput, body, allocator);
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
    if (std.mem.eql(u8, error_code, "ConformancePackTemplateValidationException")) {
        const parsed_error: ?errors.ConformancePackTemplateValidationException = aws.json.parseJsonObject(errors.ConformancePackTemplateValidationException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .conformance_pack_template_validation_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "IdempotentParameterMismatch")) {
        const parsed_error: ?errors.IdempotentParameterMismatch = aws.json.parseJsonObject(errors.IdempotentParameterMismatch, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .idempotent_parameter_mismatch = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InsufficientDeliveryPolicyException")) {
        const parsed_error: ?errors.InsufficientDeliveryPolicyException = aws.json.parseJsonObject(errors.InsufficientDeliveryPolicyException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .insufficient_delivery_policy_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InsufficientPermissionsException")) {
        const parsed_error: ?errors.InsufficientPermissionsException = aws.json.parseJsonObject(errors.InsufficientPermissionsException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .insufficient_permissions_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidConfigurationRecorderNameException")) {
        const parsed_error: ?errors.InvalidConfigurationRecorderNameException = aws.json.parseJsonObject(errors.InvalidConfigurationRecorderNameException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_configuration_recorder_name_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidDeliveryChannelNameException")) {
        const parsed_error: ?errors.InvalidDeliveryChannelNameException = aws.json.parseJsonObject(errors.InvalidDeliveryChannelNameException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_delivery_channel_name_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidExpressionException")) {
        const parsed_error: ?errors.InvalidExpressionException = aws.json.parseJsonObject(errors.InvalidExpressionException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_expression_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidLimitException")) {
        const parsed_error: ?errors.InvalidLimitException = aws.json.parseJsonObject(errors.InvalidLimitException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_limit_exception = typed_error } };
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
    if (std.mem.eql(u8, error_code, "InvalidParameterValueException")) {
        const parsed_error: ?errors.InvalidParameterValueException = aws.json.parseJsonObject(errors.InvalidParameterValueException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_parameter_value_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidRecordingGroupException")) {
        const parsed_error: ?errors.InvalidRecordingGroupException = aws.json.parseJsonObject(errors.InvalidRecordingGroupException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_recording_group_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidResultTokenException")) {
        const parsed_error: ?errors.InvalidResultTokenException = aws.json.parseJsonObject(errors.InvalidResultTokenException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_result_token_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidRoleException")) {
        const parsed_error: ?errors.InvalidRoleException = aws.json.parseJsonObject(errors.InvalidRoleException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_role_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidS3KeyPrefixException")) {
        const parsed_error: ?errors.InvalidS3KeyPrefixException = aws.json.parseJsonObject(errors.InvalidS3KeyPrefixException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_s3_key_prefix_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidS3KmsKeyArnException")) {
        const parsed_error: ?errors.InvalidS3KmsKeyArnException = aws.json.parseJsonObject(errors.InvalidS3KmsKeyArnException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_s3_kms_key_arn_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidSNSTopicARNException")) {
        const parsed_error: ?errors.InvalidSNSTopicARNException = aws.json.parseJsonObject(errors.InvalidSNSTopicARNException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_sns_topic_arn_exception = typed_error } };
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
    if (std.mem.eql(u8, error_code, "LastDeliveryChannelDeleteFailedException")) {
        const parsed_error: ?errors.LastDeliveryChannelDeleteFailedException = aws.json.parseJsonObject(errors.LastDeliveryChannelDeleteFailedException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .last_delivery_channel_delete_failed_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "LimitExceededException")) {
        const parsed_error: ?errors.LimitExceededException = aws.json.parseJsonObject(errors.LimitExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .limit_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "MaxActiveResourcesExceededException")) {
        const parsed_error: ?errors.MaxActiveResourcesExceededException = aws.json.parseJsonObject(errors.MaxActiveResourcesExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .max_active_resources_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "MaxNumberOfConfigRulesExceededException")) {
        const parsed_error: ?errors.MaxNumberOfConfigRulesExceededException = aws.json.parseJsonObject(errors.MaxNumberOfConfigRulesExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .max_number_of_config_rules_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "MaxNumberOfConfigurationRecordersExceededException")) {
        const parsed_error: ?errors.MaxNumberOfConfigurationRecordersExceededException = aws.json.parseJsonObject(errors.MaxNumberOfConfigurationRecordersExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .max_number_of_configuration_recorders_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "MaxNumberOfConformancePacksExceededException")) {
        const parsed_error: ?errors.MaxNumberOfConformancePacksExceededException = aws.json.parseJsonObject(errors.MaxNumberOfConformancePacksExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .max_number_of_conformance_packs_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "MaxNumberOfDeliveryChannelsExceededException")) {
        const parsed_error: ?errors.MaxNumberOfDeliveryChannelsExceededException = aws.json.parseJsonObject(errors.MaxNumberOfDeliveryChannelsExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .max_number_of_delivery_channels_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "MaxNumberOfOrganizationConfigRulesExceededException")) {
        const parsed_error: ?errors.MaxNumberOfOrganizationConfigRulesExceededException = aws.json.parseJsonObject(errors.MaxNumberOfOrganizationConfigRulesExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .max_number_of_organization_config_rules_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "MaxNumberOfOrganizationConformancePacksExceededException")) {
        const parsed_error: ?errors.MaxNumberOfOrganizationConformancePacksExceededException = aws.json.parseJsonObject(errors.MaxNumberOfOrganizationConformancePacksExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .max_number_of_organization_conformance_packs_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "MaxNumberOfRetentionConfigurationsExceededException")) {
        const parsed_error: ?errors.MaxNumberOfRetentionConfigurationsExceededException = aws.json.parseJsonObject(errors.MaxNumberOfRetentionConfigurationsExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .max_number_of_retention_configurations_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "NoAvailableConfigurationRecorderException")) {
        const parsed_error: ?errors.NoAvailableConfigurationRecorderException = aws.json.parseJsonObject(errors.NoAvailableConfigurationRecorderException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .no_available_configuration_recorder_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "NoAvailableDeliveryChannelException")) {
        const parsed_error: ?errors.NoAvailableDeliveryChannelException = aws.json.parseJsonObject(errors.NoAvailableDeliveryChannelException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .no_available_delivery_channel_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "NoAvailableOrganizationException")) {
        const parsed_error: ?errors.NoAvailableOrganizationException = aws.json.parseJsonObject(errors.NoAvailableOrganizationException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .no_available_organization_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "NoRunningConfigurationRecorderException")) {
        const parsed_error: ?errors.NoRunningConfigurationRecorderException = aws.json.parseJsonObject(errors.NoRunningConfigurationRecorderException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .no_running_configuration_recorder_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "NoSuchBucketException")) {
        const parsed_error: ?errors.NoSuchBucketException = aws.json.parseJsonObject(errors.NoSuchBucketException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .no_such_bucket_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "NoSuchConfigRuleException")) {
        const parsed_error: ?errors.NoSuchConfigRuleException = aws.json.parseJsonObject(errors.NoSuchConfigRuleException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .no_such_config_rule_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "NoSuchConfigRuleInConformancePackException")) {
        const parsed_error: ?errors.NoSuchConfigRuleInConformancePackException = aws.json.parseJsonObject(errors.NoSuchConfigRuleInConformancePackException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .no_such_config_rule_in_conformance_pack_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "NoSuchConfigurationAggregatorException")) {
        const parsed_error: ?errors.NoSuchConfigurationAggregatorException = aws.json.parseJsonObject(errors.NoSuchConfigurationAggregatorException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .no_such_configuration_aggregator_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "NoSuchConfigurationRecorderException")) {
        const parsed_error: ?errors.NoSuchConfigurationRecorderException = aws.json.parseJsonObject(errors.NoSuchConfigurationRecorderException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .no_such_configuration_recorder_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "NoSuchConformancePackException")) {
        const parsed_error: ?errors.NoSuchConformancePackException = aws.json.parseJsonObject(errors.NoSuchConformancePackException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .no_such_conformance_pack_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "NoSuchDeliveryChannelException")) {
        const parsed_error: ?errors.NoSuchDeliveryChannelException = aws.json.parseJsonObject(errors.NoSuchDeliveryChannelException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .no_such_delivery_channel_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "NoSuchOrganizationConfigRuleException")) {
        const parsed_error: ?errors.NoSuchOrganizationConfigRuleException = aws.json.parseJsonObject(errors.NoSuchOrganizationConfigRuleException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .no_such_organization_config_rule_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "NoSuchOrganizationConformancePackException")) {
        const parsed_error: ?errors.NoSuchOrganizationConformancePackException = aws.json.parseJsonObject(errors.NoSuchOrganizationConformancePackException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .no_such_organization_conformance_pack_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "NoSuchRemediationConfigurationException")) {
        const parsed_error: ?errors.NoSuchRemediationConfigurationException = aws.json.parseJsonObject(errors.NoSuchRemediationConfigurationException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .no_such_remediation_configuration_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "NoSuchRemediationExceptionException")) {
        const parsed_error: ?errors.NoSuchRemediationExceptionException = aws.json.parseJsonObject(errors.NoSuchRemediationExceptionException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .no_such_remediation_exception_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "NoSuchRetentionConfigurationException")) {
        const parsed_error: ?errors.NoSuchRetentionConfigurationException = aws.json.parseJsonObject(errors.NoSuchRetentionConfigurationException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .no_such_retention_configuration_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "OrganizationAccessDeniedException")) {
        const parsed_error: ?errors.OrganizationAccessDeniedException = aws.json.parseJsonObject(errors.OrganizationAccessDeniedException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .organization_access_denied_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "OrganizationAllFeaturesNotEnabledException")) {
        const parsed_error: ?errors.OrganizationAllFeaturesNotEnabledException = aws.json.parseJsonObject(errors.OrganizationAllFeaturesNotEnabledException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .organization_all_features_not_enabled_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "OrganizationConformancePackTemplateValidationException")) {
        const parsed_error: ?errors.OrganizationConformancePackTemplateValidationException = aws.json.parseJsonObject(errors.OrganizationConformancePackTemplateValidationException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .organization_conformance_pack_template_validation_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "OversizedConfigurationItemException")) {
        const parsed_error: ?errors.OversizedConfigurationItemException = aws.json.parseJsonObject(errors.OversizedConfigurationItemException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .oversized_configuration_item_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "RemediationInProgressException")) {
        const parsed_error: ?errors.RemediationInProgressException = aws.json.parseJsonObject(errors.RemediationInProgressException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .remediation_in_progress_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ResourceConcurrentModificationException")) {
        const parsed_error: ?errors.ResourceConcurrentModificationException = aws.json.parseJsonObject(errors.ResourceConcurrentModificationException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .resource_concurrent_modification_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ResourceInUseException")) {
        const parsed_error: ?errors.ResourceInUseException = aws.json.parseJsonObject(errors.ResourceInUseException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .resource_in_use_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ResourceNotDiscoveredException")) {
        const parsed_error: ?errors.ResourceNotDiscoveredException = aws.json.parseJsonObject(errors.ResourceNotDiscoveredException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .resource_not_discovered_exception = typed_error } };
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
    if (std.mem.eql(u8, error_code, "TooManyTagsException")) {
        const parsed_error: ?errors.TooManyTagsException = aws.json.parseJsonObject(errors.TooManyTagsException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .too_many_tags_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "UnmodifiableEntityException")) {
        const parsed_error: ?errors.UnmodifiableEntityException = aws.json.parseJsonObject(errors.UnmodifiableEntityException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .unmodifiable_entity_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ValidationException")) {
        const parsed_error: ?errors.ValidationException = aws.json.parseJsonObject(errors.ValidationException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .validation_exception = typed_error } };
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
