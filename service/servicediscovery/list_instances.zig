const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const errors = @import("errors.zig");
const ServiceError = errors.ServiceError;
const InstanceSummary = @import("instance_summary.zig").InstanceSummary;

pub const ListInstancesInput = struct {
    /// The maximum number of instances that you want Cloud Map to return in the
    /// response to a
    /// `ListInstances` request. If you don't specify a value for `MaxResults`,
    /// Cloud Map returns up to 100 instances.
    max_results: ?i32 = null,

    /// For the first `ListInstances` request, omit this value.
    ///
    /// If more than `MaxResults` instances match the specified criteria, you can
    /// submit
    /// another `ListInstances` request to get the next group of results. Specify
    /// the value of
    /// `NextToken` from the previous response in the next request.
    next_token: ?[]const u8 = null,

    /// The ID or Amazon Resource Name (ARN) of the service that you want to list
    /// instances for. For services created
    /// in a shared namespace, specify the service ARN. For more information about
    /// shared namespaces,
    /// see [Cross-account
    /// Cloud Map namespace
    /// sharing](https://docs.aws.amazon.com/cloud-map/latest/dg/sharing-namespaces.html) in the *Cloud Map Developer Guide*.
    service_id: []const u8,

    pub const json_field_names = .{
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .service_id = "ServiceId",
    };
};

pub const ListInstancesOutput = struct {
    /// Summary information about the instances that are associated with the
    /// specified
    /// service.
    instances: ?[]const InstanceSummary = null,

    /// If more than `MaxResults` instances match the specified criteria, you can
    /// submit
    /// another `ListInstances` request to get the next group of results. Specify
    /// the value of
    /// `NextToken` from the previous response in the next request.
    next_token: ?[]const u8 = null,

    /// The ID of the Amazon Web Services account that created the namespace that
    /// contains the specified service.
    /// If this isn't your account ID, it's the ID of the account that shared the
    /// namespace with your
    /// account.
    resource_owner: ?[]const u8 = null,

    pub const json_field_names = .{
        .instances = "Instances",
        .next_token = "NextToken",
        .resource_owner = "ResourceOwner",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListInstancesInput, options: CallOptions) !ListInstancesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "servicediscovery", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListInstancesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("servicediscovery", "ServiceDiscovery", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "Route53AutoNaming_v20170314.ListInstances");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListInstancesOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListInstancesOutput, body, allocator);
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

    if (std.mem.eql(u8, error_code, "CustomHealthNotFound")) {
        const parsed_error: ?errors.CustomHealthNotFound = aws.json.parseJsonObject(errors.CustomHealthNotFound, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .custom_health_not_found = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "DuplicateRequest")) {
        const parsed_error: ?errors.DuplicateRequest = aws.json.parseJsonObject(errors.DuplicateRequest, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .duplicate_request = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InstanceNotFound")) {
        const parsed_error: ?errors.InstanceNotFound = aws.json.parseJsonObject(errors.InstanceNotFound, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .instance_not_found = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidInput")) {
        const parsed_error: ?errors.InvalidInput = aws.json.parseJsonObject(errors.InvalidInput, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_input = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "NamespaceAlreadyExists")) {
        const parsed_error: ?errors.NamespaceAlreadyExists = aws.json.parseJsonObject(errors.NamespaceAlreadyExists, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .namespace_already_exists = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "NamespaceNotFound")) {
        const parsed_error: ?errors.NamespaceNotFound = aws.json.parseJsonObject(errors.NamespaceNotFound, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .namespace_not_found = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "OperationNotFound")) {
        const parsed_error: ?errors.OperationNotFound = aws.json.parseJsonObject(errors.OperationNotFound, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .operation_not_found = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "RequestLimitExceeded")) {
        const parsed_error: ?errors.RequestLimitExceeded = aws.json.parseJsonObject(errors.RequestLimitExceeded, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .request_limit_exceeded = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ResourceInUse")) {
        const parsed_error: ?errors.ResourceInUse = aws.json.parseJsonObject(errors.ResourceInUse, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .resource_in_use = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ResourceLimitExceeded")) {
        const parsed_error: ?errors.ResourceLimitExceeded = aws.json.parseJsonObject(errors.ResourceLimitExceeded, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .resource_limit_exceeded = typed_error } };
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
    if (std.mem.eql(u8, error_code, "ServiceAlreadyExists")) {
        const parsed_error: ?errors.ServiceAlreadyExists = aws.json.parseJsonObject(errors.ServiceAlreadyExists, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .service_already_exists = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ServiceAttributesLimitExceededException")) {
        const parsed_error: ?errors.ServiceAttributesLimitExceededException = aws.json.parseJsonObject(errors.ServiceAttributesLimitExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .service_attributes_limit_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ServiceNotFound")) {
        const parsed_error: ?errors.ServiceNotFound = aws.json.parseJsonObject(errors.ServiceNotFound, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .service_not_found = typed_error } };
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

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
