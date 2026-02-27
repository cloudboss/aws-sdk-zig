const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const TimeRange = @import("time_range.zig").TimeRange;
const AttackSummary = @import("attack_summary.zig").AttackSummary;

pub const ListAttacksInput = struct {
    /// The end of the time period for the attacks. This is a `timestamp` type. The
    /// request syntax listing for this call indicates a `number` type,
    /// but you can provide the time in any valid [timestamp
    /// format](https://docs.aws.amazon.com/cli/latest/userguide/cli-usage-parameters-types.html#parameter-type-timestamp) setting.
    end_time: ?TimeRange = null,

    /// The greatest number of objects that you want Shield Advanced to return to
    /// the list request. Shield Advanced might return fewer objects
    /// than you indicate in this setting, even if more objects are available. If
    /// there are more objects remaining, Shield Advanced will always also return a
    /// `NextToken` value
    /// in the response.
    ///
    /// The default setting is 20.
    max_results: ?i32 = null,

    /// When you request a list of objects from Shield Advanced, if the response
    /// does not include all of the remaining available objects,
    /// Shield Advanced includes a `NextToken` value in the response. You can
    /// retrieve the next batch of objects by requesting the list again and
    /// providing the token that was returned by the prior call in your request.
    ///
    /// You can indicate the maximum number of objects that you want Shield Advanced
    /// to return for a single call with the `MaxResults`
    /// setting. Shield Advanced will not return more than `MaxResults` objects, but
    /// may return fewer, even if more objects are still available.
    ///
    /// Whenever more objects remain that Shield Advanced has not yet returned to
    /// you, the response will include a `NextToken` value.
    ///
    /// On your first call to a list operation, leave this setting empty.
    next_token: ?[]const u8 = null,

    /// The ARNs (Amazon Resource Names) of the resources that were attacked. If you
    /// leave this
    /// blank, all applicable resources for this account will be included.
    resource_arns: ?[]const []const u8 = null,

    /// The start of the time period for the attacks. This is a `timestamp` type.
    /// The request syntax listing for this call indicates a `number` type,
    /// but you can provide the time in any valid [timestamp
    /// format](https://docs.aws.amazon.com/cli/latest/userguide/cli-usage-parameters-types.html#parameter-type-timestamp) setting.
    start_time: ?TimeRange = null,

    pub const json_field_names = .{
        .end_time = "EndTime",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .resource_arns = "ResourceArns",
        .start_time = "StartTime",
    };
};

pub const ListAttacksOutput = struct {
    /// The attack information for the specified time range.
    attack_summaries: ?[]const AttackSummary = null,

    /// When you request a list of objects from Shield Advanced, if the response
    /// does not include all of the remaining available objects,
    /// Shield Advanced includes a `NextToken` value in the response. You can
    /// retrieve the next batch of objects by requesting the list again and
    /// providing the token that was returned by the prior call in your request.
    ///
    /// You can indicate the maximum number of objects that you want Shield Advanced
    /// to return for a single call with the `MaxResults`
    /// setting. Shield Advanced will not return more than `MaxResults` objects, but
    /// may return fewer, even if more objects are still available.
    ///
    /// Whenever more objects remain that Shield Advanced has not yet returned to
    /// you, the response will include a `NextToken` value.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .attack_summaries = "AttackSummaries",
        .next_token = "NextToken",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListAttacksInput, options: Options) !ListAttacksOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "shield");

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

fn serializeRequest(alloc: std.mem.Allocator, input: ListAttacksInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("shield", "Shield", alloc);

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
    try request.headers.put(alloc, "X-Amz-Target", "AWSShield_20160616.ListAttacks");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !ListAttacksOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListAttacksOutput, body, alloc);
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

    if (std.mem.eql(u8, error_code, "AccessDeniedException")) {
        return .{ .arena = arena, .kind = .{ .access_denied_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "AccessDeniedForDependencyException")) {
        return .{ .arena = arena, .kind = .{ .access_denied_for_dependency_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalErrorException")) {
        return .{ .arena = arena, .kind = .{ .internal_error_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidOperationException")) {
        return .{ .arena = arena, .kind = .{ .invalid_operation_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidPaginationTokenException")) {
        return .{ .arena = arena, .kind = .{ .invalid_pagination_token_exception = .{
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
    if (std.mem.eql(u8, error_code, "InvalidResourceException")) {
        return .{ .arena = arena, .kind = .{ .invalid_resource_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "LimitsExceededException")) {
        return .{ .arena = arena, .kind = .{ .limits_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "LockedSubscriptionException")) {
        return .{ .arena = arena, .kind = .{ .locked_subscription_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NoAssociatedRoleException")) {
        return .{ .arena = arena, .kind = .{ .no_associated_role_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "OptimisticLockException")) {
        return .{ .arena = arena, .kind = .{ .optimistic_lock_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceAlreadyExistsException")) {
        return .{ .arena = arena, .kind = .{ .resource_already_exists_exception = .{
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

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
