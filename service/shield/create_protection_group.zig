const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const ProtectionGroupAggregation = @import("protection_group_aggregation.zig").ProtectionGroupAggregation;
const ProtectionGroupPattern = @import("protection_group_pattern.zig").ProtectionGroupPattern;
const ProtectedResourceType = @import("protected_resource_type.zig").ProtectedResourceType;
const Tag = @import("tag.zig").Tag;

pub const CreateProtectionGroupInput = struct {
    /// Defines how Shield combines resource data for the group in order to detect,
    /// mitigate, and report events.
    ///
    /// * Sum - Use the total traffic across the group. This is a good choice for
    ///   most cases. Examples include Elastic IP addresses for EC2 instances that
    ///   scale manually or automatically.
    ///
    /// * Mean - Use the average of the traffic across the group. This is a good
    ///   choice for resources that share traffic uniformly. Examples include
    ///   accelerators and load balancers.
    ///
    /// * Max - Use the highest traffic from each resource. This is useful for
    ///   resources that don't share traffic and for resources that share that
    ///   traffic in a non-uniform way. Examples include Amazon CloudFront and
    ///   origin resources for CloudFront distributions.
    aggregation: ProtectionGroupAggregation,

    /// The Amazon Resource Names (ARNs) of the resources to include in the
    /// protection group. You must set this when you set `Pattern` to `ARBITRARY`
    /// and you must not set it for any other `Pattern` setting.
    members: ?[]const []const u8 = null,

    /// The criteria to use to choose the protected resources for inclusion in the
    /// group. You can include all resources that have protections, provide a list
    /// of resource Amazon Resource Names (ARNs), or include all resources of a
    /// specified resource type.
    pattern: ProtectionGroupPattern,

    /// The name of the protection group. You use this to identify the protection
    /// group in lists and to manage the protection group, for example to update,
    /// delete, or describe it.
    protection_group_id: []const u8,

    /// The resource type to include in the protection group. All protected
    /// resources of this type are included in the protection group. Newly protected
    /// resources of this type are automatically added to the group.
    /// You must set this when you set `Pattern` to `BY_RESOURCE_TYPE` and you must
    /// not set it for any other `Pattern` setting.
    resource_type: ?ProtectedResourceType = null,

    /// One or more tag key-value pairs for the protection group.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .aggregation = "Aggregation",
        .members = "Members",
        .pattern = "Pattern",
        .protection_group_id = "ProtectionGroupId",
        .resource_type = "ResourceType",
        .tags = "Tags",
    };
};

pub const CreateProtectionGroupOutput = struct {
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateProtectionGroupInput, options: CallOptions) !CreateProtectionGroupOutput {
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
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: CreateProtectionGroupInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("shield", "Shield", allocator);

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
    try request.headers.put(allocator, "X-Amz-Target", "AWSShield_20160616.CreateProtectionGroup");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateProtectionGroupOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
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
