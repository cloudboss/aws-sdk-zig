const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const LogScope = @import("log_scope.zig").LogScope;
const LogType = @import("log_type.zig").LogType;

pub const DeleteLoggingConfigurationInput = struct {
    /// The owner of the logging configuration, which must be set to `CUSTOMER` for
    /// the configurations that you manage.
    ///
    /// The log scope `SECURITY_LAKE` indicates a configuration that is managed
    /// through Amazon Security Lake. You can use Security Lake to collect log and
    /// event data from various sources for normalization, analysis, and management.
    /// For information, see
    /// [Collecting data from Amazon Web Services
    /// services](https://docs.aws.amazon.com/security-lake/latest/userguide/internal-sources.html)
    /// in the *Amazon Security Lake user guide*.
    ///
    /// The log scope `CLOUDWATCH_TELEMETRY_RULE_MANAGED` indicates a configuration
    /// that is managed through Amazon CloudWatch Logs for telemetry data collection
    /// and analysis. For information, see
    /// [What is Amazon CloudWatch Logs
    /// ?](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/WhatIsCloudWatchLogs.html)
    /// in the *Amazon CloudWatch Logs user guide*.
    ///
    /// Default: `CUSTOMER`
    log_scope: ?LogScope = null,

    /// Used to distinguish between various logging options. Currently, there is one
    /// option.
    ///
    /// Default: `WAF_LOGS`
    log_type: ?LogType = null,

    /// The Amazon Resource Name (ARN) of the web ACL from which you want to delete
    /// the LoggingConfiguration.
    resource_arn: []const u8,

    pub const json_field_names = .{
        .log_scope = "LogScope",
        .log_type = "LogType",
        .resource_arn = "ResourceArn",
    };
};

pub const DeleteLoggingConfigurationOutput = struct {
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteLoggingConfigurationInput, options: Options) !DeleteLoggingConfigurationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "wafv2");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(response.body, response.status, response.headers, allocator);
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: DeleteLoggingConfigurationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("wafv2", "WAFV2", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(alloc, "X-Amz-Target", "AWSWAF_20190729.DeleteLoggingConfiguration");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !DeleteLoggingConfigurationOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = alloc;
    return .{};
}

fn parseErrorResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(alloc);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "WAFAssociatedItemException")) {
        return .{ .arena = arena, .kind = .{ .waf_associated_item_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "WAFConfigurationWarningException")) {
        return .{ .arena = arena, .kind = .{ .waf_configuration_warning_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "WAFDuplicateItemException")) {
        return .{ .arena = arena, .kind = .{ .waf_duplicate_item_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "WAFExpiredManagedRuleGroupVersionException")) {
        return .{ .arena = arena, .kind = .{ .waf_expired_managed_rule_group_version_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "WAFFeatureNotIncludedInPricingPlanException")) {
        return .{ .arena = arena, .kind = .{ .waf_feature_not_included_in_pricing_plan_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "WAFInternalErrorException")) {
        return .{ .arena = arena, .kind = .{ .waf_internal_error_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "WAFInvalidOperationException")) {
        return .{ .arena = arena, .kind = .{ .waf_invalid_operation_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "WAFInvalidParameterException")) {
        return .{ .arena = arena, .kind = .{ .waf_invalid_parameter_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "WAFInvalidPermissionPolicyException")) {
        return .{ .arena = arena, .kind = .{ .waf_invalid_permission_policy_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "WAFInvalidResourceException")) {
        return .{ .arena = arena, .kind = .{ .waf_invalid_resource_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "WAFLimitsExceededException")) {
        return .{ .arena = arena, .kind = .{ .waf_limits_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "WAFLogDestinationPermissionIssueException")) {
        return .{ .arena = arena, .kind = .{ .waf_log_destination_permission_issue_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "WAFNonexistentItemException")) {
        return .{ .arena = arena, .kind = .{ .waf_nonexistent_item_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "WAFOptimisticLockException")) {
        return .{ .arena = arena, .kind = .{ .waf_optimistic_lock_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "WAFServiceLinkedRoleErrorException")) {
        return .{ .arena = arena, .kind = .{ .waf_service_linked_role_error_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "WAFSubscriptionNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .waf_subscription_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "WAFTagOperationException")) {
        return .{ .arena = arena, .kind = .{ .waf_tag_operation_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "WAFTagOperationInternalErrorException")) {
        return .{ .arena = arena, .kind = .{ .waf_tag_operation_internal_error_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "WAFUnavailableEntityException")) {
        return .{ .arena = arena, .kind = .{ .waf_unavailable_entity_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "WAFUnsupportedAggregateKeyTypeException")) {
        return .{ .arena = arena, .kind = .{ .waf_unsupported_aggregate_key_type_exception = .{
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
