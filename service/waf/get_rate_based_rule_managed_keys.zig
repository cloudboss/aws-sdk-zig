const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;

pub const GetRateBasedRuleManagedKeysInput = struct {
    /// A null value and not currently used. Do not include this in your request.
    next_marker: ?[]const u8 = null,

    /// The `RuleId` of the RateBasedRule for which you want to
    /// get a list of `ManagedKeys`. `RuleId` is returned by CreateRateBasedRule and
    /// by ListRateBasedRules.
    rule_id: []const u8,

    pub const json_field_names = .{
        .next_marker = "NextMarker",
        .rule_id = "RuleId",
    };
};

pub const GetRateBasedRuleManagedKeysOutput = struct {
    /// An array of IP addresses that currently are blocked by the specified
    /// RateBasedRule.
    managed_keys: ?[]const []const u8 = null,

    /// A null value and not currently used.
    next_marker: ?[]const u8 = null,

    pub const json_field_names = .{
        .managed_keys = "ManagedKeys",
        .next_marker = "NextMarker",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetRateBasedRuleManagedKeysInput, options: CallOptions) !GetRateBasedRuleManagedKeysOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "waf");

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetRateBasedRuleManagedKeysInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("waf", "WAF", allocator);

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
    try request.headers.put(allocator, "X-Amz-Target", "AWSWAF_20150824.GetRateBasedRuleManagedKeys");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetRateBasedRuleManagedKeysOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetRateBasedRuleManagedKeysOutput, body, allocator);
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

    if (std.mem.eql(u8, error_code, "WAFBadRequestException")) {
        return .{ .arena = arena, .kind = .{ .waf_bad_request_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "WAFDisallowedNameException")) {
        return .{ .arena = arena, .kind = .{ .waf_disallowed_name_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "WAFEntityMigrationException")) {
        return .{ .arena = arena, .kind = .{ .waf_entity_migration_exception = .{
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
    if (std.mem.eql(u8, error_code, "WAFInvalidAccountException")) {
        return .{ .arena = arena, .kind = .{ .waf_invalid_account_exception = .{
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
    if (std.mem.eql(u8, error_code, "WAFInvalidRegexPatternException")) {
        return .{ .arena = arena, .kind = .{ .waf_invalid_regex_pattern_exception = .{
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
    if (std.mem.eql(u8, error_code, "WAFNonEmptyEntityException")) {
        return .{ .arena = arena, .kind = .{ .waf_non_empty_entity_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "WAFNonexistentContainerException")) {
        return .{ .arena = arena, .kind = .{ .waf_nonexistent_container_exception = .{
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
    if (std.mem.eql(u8, error_code, "WAFReferencedItemException")) {
        return .{ .arena = arena, .kind = .{ .waf_referenced_item_exception = .{
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
    if (std.mem.eql(u8, error_code, "WAFStaleDataException")) {
        return .{ .arena = arena, .kind = .{ .waf_stale_data_exception = .{
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

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
