const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const errors = @import("errors.zig");
const ServiceError = errors.ServiceError;
const TimeWindow = @import("time_window.zig").TimeWindow;
const SampledHTTPRequest = @import("sampled_http_request.zig").SampledHTTPRequest;

pub const GetSampledRequestsInput = struct {
    /// The number of requests that you want AWS WAF to return from among the first
    /// 5,000 requests that your AWS resource received
    /// during the time range. If your resource received fewer requests than the
    /// value of `MaxItems`, `GetSampledRequests`
    /// returns information about all of them.
    max_items: i64,

    /// `RuleId` is one of three values:
    ///
    /// * The `RuleId` of the `Rule` or the `RuleGroupId` of the `RuleGroup` for
    ///   which you want `GetSampledRequests` to return a sample of requests.
    ///
    /// * `Default_Action`, which causes `GetSampledRequests` to return a sample of
    ///   the requests that
    /// didn't match any of the rules in the specified `WebACL`.
    rule_id: []const u8,

    /// The start date and time and the end date and time of the range for which you
    /// want `GetSampledRequests` to return a
    /// sample of requests. You must specify the times in Coordinated Universal Time
    /// (UTC) format. UTC format includes the special
    /// designator, `Z`. For example, `"2016-09-27T14:50Z"`. You can specify any
    /// time range in the previous three hours.
    time_window: TimeWindow,

    /// The `WebACLId` of the `WebACL` for which you want `GetSampledRequests` to
    /// return a sample of requests.
    web_acl_id: []const u8,

    pub const json_field_names = .{
        .max_items = "MaxItems",
        .rule_id = "RuleId",
        .time_window = "TimeWindow",
        .web_acl_id = "WebAclId",
    };
};

pub const GetSampledRequestsOutput = struct {
    /// The total number of requests from which `GetSampledRequests` got a sample of
    /// `MaxItems` requests.
    /// If `PopulationSize` is less than `MaxItems`, the sample includes every
    /// request that your AWS resource
    /// received during the specified time range.
    population_size: ?i64 = null,

    /// A complex type that contains detailed information about each of the requests
    /// in the sample.
    sampled_requests: ?[]const SampledHTTPRequest = null,

    /// Usually, `TimeWindow` is the time range that you specified in the
    /// `GetSampledRequests` request. However,
    /// if your AWS resource received more than 5,000 requests during the time range
    /// that you specified in the request,
    /// `GetSampledRequests` returns the time range for the first 5,000 requests.
    /// Times are in Coordinated Universal Time (UTC) format.
    time_window: ?TimeWindow = null,

    pub const json_field_names = .{
        .population_size = "PopulationSize",
        .sampled_requests = "SampledRequests",
        .time_window = "TimeWindow",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetSampledRequestsInput, options: CallOptions) !GetSampledRequestsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "waf-regional", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetSampledRequestsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("waf-regional", "WAF Regional", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSWAF_Regional_20161128.GetSampledRequests");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetSampledRequestsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetSampledRequestsOutput, body, allocator);
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

    if (std.mem.eql(u8, error_code, "WAFBadRequestException")) {
        const parsed_error: ?errors.WAFBadRequestException = aws.json.parseJsonObject(errors.WAFBadRequestException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .waf_bad_request_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "WAFDisallowedNameException")) {
        const parsed_error: ?errors.WAFDisallowedNameException = aws.json.parseJsonObject(errors.WAFDisallowedNameException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .waf_disallowed_name_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "WAFEntityMigrationException")) {
        const parsed_error: ?errors.WAFEntityMigrationException = aws.json.parseJsonObject(errors.WAFEntityMigrationException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .waf_entity_migration_exception = typed_error } };
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
    if (std.mem.eql(u8, error_code, "WAFInvalidAccountException")) {
        const parsed_error: ?errors.WAFInvalidAccountException = aws.json.parseJsonObject(errors.WAFInvalidAccountException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .waf_invalid_account_exception = typed_error } };
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
    if (std.mem.eql(u8, error_code, "WAFInvalidRegexPatternException")) {
        const parsed_error: ?errors.WAFInvalidRegexPatternException = aws.json.parseJsonObject(errors.WAFInvalidRegexPatternException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .waf_invalid_regex_pattern_exception = typed_error } };
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
    if (std.mem.eql(u8, error_code, "WAFNonEmptyEntityException")) {
        const parsed_error: ?errors.WAFNonEmptyEntityException = aws.json.parseJsonObject(errors.WAFNonEmptyEntityException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .waf_non_empty_entity_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "WAFNonexistentContainerException")) {
        const parsed_error: ?errors.WAFNonexistentContainerException = aws.json.parseJsonObject(errors.WAFNonexistentContainerException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .waf_nonexistent_container_exception = typed_error } };
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
    if (std.mem.eql(u8, error_code, "WAFReferencedItemException")) {
        const parsed_error: ?errors.WAFReferencedItemException = aws.json.parseJsonObject(errors.WAFReferencedItemException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .waf_referenced_item_exception = typed_error } };
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
    if (std.mem.eql(u8, error_code, "WAFStaleDataException")) {
        const parsed_error: ?errors.WAFStaleDataException = aws.json.parseJsonObject(errors.WAFStaleDataException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .waf_stale_data_exception = typed_error } };
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

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
