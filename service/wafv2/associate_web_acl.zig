const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const errors = @import("errors.zig");
const ServiceError = errors.ServiceError;

pub const AssociateWebACLInput = struct {
    /// The Amazon Resource Name (ARN) of the resource to associate with the web
    /// ACL.
    ///
    /// The ARN must be in one of the following formats:
    ///
    /// * For an Application Load Balancer:
    ///   `arn:*partition*:elasticloadbalancing:*region*:*account-id*:loadbalancer/app/*load-balancer-name*/*load-balancer-id*
    /// `
    ///
    /// * For an Amazon API Gateway REST API:
    ///   `arn:*partition*:apigateway:*region*::/restapis/*api-id*/stages/*stage-name*
    /// `
    ///
    /// * For an AppSync GraphQL API:
    ///   `arn:*partition*:appsync:*region*:*account-id*:apis/*GraphQLApiId*
    /// `
    ///
    /// * For an Amazon Cognito user pool:
    ///   `arn:*partition*:cognito-idp:*region*:*account-id*:userpool/*user-pool-id*
    /// `
    ///
    /// * For an App Runner service:
    ///   `arn:*partition*:apprunner:*region*:*account-id*:service/*apprunner-service-name*/*apprunner-service-id*
    /// `
    ///
    /// * For an Amazon Web Services Verified Access instance:
    ///   `arn:*partition*:ec2:*region*:*account-id*:verified-access-instance/*instance-id*
    /// `
    ///
    /// * For an Amplify application:
    ///   `arn:*partition*:amplify:*region*:*account-id*:apps/*app-id*
    /// `
    resource_arn: []const u8,

    /// The Amazon Resource Name (ARN) of the web ACL that you want to associate
    /// with the
    /// resource.
    web_acl_arn: []const u8,

    pub const json_field_names = .{
        .resource_arn = "ResourceArn",
        .web_acl_arn = "WebACLArn",
    };
};

pub const AssociateWebACLOutput = struct {
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: AssociateWebACLInput, options: CallOptions) !AssociateWebACLOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "wafv2", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: AssociateWebACLInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("wafv2", "WAFV2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSWAF_20190729.AssociateWebACL");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !AssociateWebACLOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
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

    if (std.mem.eql(u8, error_code, "WAFAssociatedItemException")) {
        const parsed_error: ?errors.WAFAssociatedItemException = aws.json.parseJsonObject(errors.WAFAssociatedItemException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .waf_associated_item_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "WAFConfigurationWarningException")) {
        const parsed_error: ?errors.WAFConfigurationWarningException = aws.json.parseJsonObject(errors.WAFConfigurationWarningException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .waf_configuration_warning_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "WAFDuplicateItemException")) {
        const parsed_error: ?errors.WAFDuplicateItemException = aws.json.parseJsonObject(errors.WAFDuplicateItemException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .waf_duplicate_item_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "WAFExpiredManagedRuleGroupVersionException")) {
        const parsed_error: ?errors.WAFExpiredManagedRuleGroupVersionException = aws.json.parseJsonObject(errors.WAFExpiredManagedRuleGroupVersionException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .waf_expired_managed_rule_group_version_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "WAFFeatureNotIncludedInPricingPlanException")) {
        const parsed_error: ?errors.WAFFeatureNotIncludedInPricingPlanException = aws.json.parseJsonObject(errors.WAFFeatureNotIncludedInPricingPlanException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .waf_feature_not_included_in_pricing_plan_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "WAFInternalErrorException")) {
        const parsed_error: ?errors.WAFInternalErrorException = aws.json.parseJsonObject(errors.WAFInternalErrorException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .waf_internal_error_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "WAFInvalidOperationException")) {
        const parsed_error: ?errors.WAFInvalidOperationException = aws.json.parseJsonObject(errors.WAFInvalidOperationException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .waf_invalid_operation_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "WAFInvalidParameterException")) {
        const parsed_error: ?errors.WAFInvalidParameterException = aws.json.parseJsonObject(errors.WAFInvalidParameterException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .waf_invalid_parameter_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "WAFInvalidPermissionPolicyException")) {
        const parsed_error: ?errors.WAFInvalidPermissionPolicyException = aws.json.parseJsonObject(errors.WAFInvalidPermissionPolicyException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .waf_invalid_permission_policy_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "WAFInvalidResourceException")) {
        const parsed_error: ?errors.WAFInvalidResourceException = aws.json.parseJsonObject(errors.WAFInvalidResourceException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .waf_invalid_resource_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "WAFLimitsExceededException")) {
        const parsed_error: ?errors.WAFLimitsExceededException = aws.json.parseJsonObject(errors.WAFLimitsExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .waf_limits_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "WAFLogDestinationPermissionIssueException")) {
        const parsed_error: ?errors.WAFLogDestinationPermissionIssueException = aws.json.parseJsonObject(errors.WAFLogDestinationPermissionIssueException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .waf_log_destination_permission_issue_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "WAFNonexistentItemException")) {
        const parsed_error: ?errors.WAFNonexistentItemException = aws.json.parseJsonObject(errors.WAFNonexistentItemException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .waf_nonexistent_item_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "WAFOptimisticLockException")) {
        const parsed_error: ?errors.WAFOptimisticLockException = aws.json.parseJsonObject(errors.WAFOptimisticLockException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .waf_optimistic_lock_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "WAFServiceLinkedRoleErrorException")) {
        const parsed_error: ?errors.WAFServiceLinkedRoleErrorException = aws.json.parseJsonObject(errors.WAFServiceLinkedRoleErrorException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .waf_service_linked_role_error_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "WAFSubscriptionNotFoundException")) {
        const parsed_error: ?errors.WAFSubscriptionNotFoundException = aws.json.parseJsonObject(errors.WAFSubscriptionNotFoundException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .waf_subscription_not_found_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "WAFTagOperationException")) {
        const parsed_error: ?errors.WAFTagOperationException = aws.json.parseJsonObject(errors.WAFTagOperationException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .waf_tag_operation_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "WAFTagOperationInternalErrorException")) {
        const parsed_error: ?errors.WAFTagOperationInternalErrorException = aws.json.parseJsonObject(errors.WAFTagOperationInternalErrorException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .waf_tag_operation_internal_error_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "WAFUnavailableEntityException")) {
        const parsed_error: ?errors.WAFUnavailableEntityException = aws.json.parseJsonObject(errors.WAFUnavailableEntityException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .waf_unavailable_entity_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "WAFUnsupportedAggregateKeyTypeException")) {
        const parsed_error: ?errors.WAFUnsupportedAggregateKeyTypeException = aws.json.parseJsonObject(errors.WAFUnsupportedAggregateKeyTypeException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .waf_unsupported_aggregate_key_type_exception = typed_error } };
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
