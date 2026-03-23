const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const LogScope = @import("log_scope.zig").LogScope;
const Scope = @import("scope.zig").Scope;
const LoggingConfiguration = @import("logging_configuration.zig").LoggingConfiguration;

pub const ListLoggingConfigurationsInput = struct {
    /// The maximum number of objects that you want WAF to return for this request.
    /// If more
    /// objects are available, in the response, WAF provides a
    /// `NextMarker` value that you can use in a subsequent call to get the next
    /// batch of objects.
    limit: ?i32 = null,

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

    /// When you request a list of objects with a `Limit` setting, if the number of
    /// objects that are still available
    /// for retrieval exceeds the limit, WAF returns a `NextMarker`
    /// value in the response. To retrieve the next batch of objects, provide the
    /// marker from the prior call in your next request.
    next_marker: ?[]const u8 = null,

    /// Specifies whether this is for a global resource type, such as a Amazon
    /// CloudFront distribution. For an Amplify application, use `CLOUDFRONT`.
    ///
    /// To work with CloudFront, you must also specify the Region US East (N.
    /// Virginia) as follows:
    ///
    /// * CLI - Specify the Region when you use the CloudFront scope:
    ///   `--scope=CLOUDFRONT --region=us-east-1`.
    ///
    /// * API and SDKs - For all calls, use the Region endpoint us-east-1.
    scope: Scope,

    pub const json_field_names = .{
        .limit = "Limit",
        .log_scope = "LogScope",
        .next_marker = "NextMarker",
        .scope = "Scope",
    };
};

pub const ListLoggingConfigurationsOutput = struct {
    /// Array of logging configurations. If you specified a `Limit` in your request,
    /// this might not be the full list.
    logging_configurations: ?[]const LoggingConfiguration = null,

    /// When you request a list of objects with a `Limit` setting, if the number of
    /// objects that are still available
    /// for retrieval exceeds the limit, WAF returns a `NextMarker`
    /// value in the response. To retrieve the next batch of objects, provide the
    /// marker from the prior call in your next request.
    next_marker: ?[]const u8 = null,

    pub const json_field_names = .{
        .logging_configurations = "LoggingConfigurations",
        .next_marker = "NextMarker",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListLoggingConfigurationsInput, options: CallOptions) !ListLoggingConfigurationsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "wafv2");

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListLoggingConfigurationsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("wafv2", "WAFV2", allocator);

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
    try request.headers.put(allocator, "X-Amz-Target", "AWSWAF_20190729.ListLoggingConfigurations");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListLoggingConfigurationsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListLoggingConfigurationsOutput, body, allocator);
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
