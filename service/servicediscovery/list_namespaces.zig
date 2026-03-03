const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const NamespaceFilter = @import("namespace_filter.zig").NamespaceFilter;
const NamespaceSummary = @import("namespace_summary.zig").NamespaceSummary;

pub const ListNamespacesInput = struct {
    /// A complex type that contains specifications for the namespaces that you want
    /// to list.
    ///
    /// If you specify more than one filter, a namespace must match all filters to
    /// be returned by
    /// `ListNamespaces`.
    filters: ?[]const NamespaceFilter = null,

    /// The maximum number of namespaces that you want Cloud Map to return in the
    /// response to a
    /// `ListNamespaces` request. If you don't specify a value for `MaxResults`,
    /// Cloud Map returns up to 100 namespaces.
    max_results: ?i32 = null,

    /// For the first `ListNamespaces` request, omit this value.
    ///
    /// If the response contains `NextToken`, submit another `ListNamespaces`
    /// request to get the next group of results. Specify the value of `NextToken`
    /// from the
    /// previous response in the next request.
    ///
    /// Cloud Map gets `MaxResults` namespaces and then filters them based on the
    /// specified criteria. It's possible that no namespaces in the first
    /// `MaxResults`
    /// namespaces matched the specified criteria but that subsequent groups of
    /// `MaxResults`
    /// namespaces do contain namespaces that match the criteria.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .filters = "Filters",
        .max_results = "MaxResults",
        .next_token = "NextToken",
    };
};

pub const ListNamespacesOutput = struct {
    /// An array that contains one `NamespaceSummary` object for each namespace that
    /// matches the specified filter criteria.
    namespaces: ?[]const NamespaceSummary = null,

    /// If the response contains `NextToken`, submit another `ListNamespaces`
    /// request to get the next group of results. Specify the value of `NextToken`
    /// from the
    /// previous response in the next request.
    ///
    /// Cloud Map gets `MaxResults` namespaces and then filters them based on the
    /// specified criteria. It's possible that no namespaces in the first
    /// `MaxResults`
    /// namespaces matched the specified criteria but that subsequent groups of
    /// `MaxResults`
    /// namespaces do contain namespaces that match the criteria.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .namespaces = "Namespaces",
        .next_token = "NextToken",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListNamespacesInput, options: Options) !ListNamespacesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "servicediscovery");

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListNamespacesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("servicediscovery", "ServiceDiscovery", allocator);

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
    try request.headers.put(allocator, "X-Amz-Target", "Route53AutoNaming_v20170314.ListNamespaces");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListNamespacesOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListNamespacesOutput, body, allocator);
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

    if (std.mem.eql(u8, error_code, "CustomHealthNotFound")) {
        return .{ .arena = arena, .kind = .{ .custom_health_not_found = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DuplicateRequest")) {
        return .{ .arena = arena, .kind = .{ .duplicate_request = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InstanceNotFound")) {
        return .{ .arena = arena, .kind = .{ .instance_not_found = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidInput")) {
        return .{ .arena = arena, .kind = .{ .invalid_input = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NamespaceAlreadyExists")) {
        return .{ .arena = arena, .kind = .{ .namespace_already_exists = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NamespaceNotFound")) {
        return .{ .arena = arena, .kind = .{ .namespace_not_found = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "OperationNotFound")) {
        return .{ .arena = arena, .kind = .{ .operation_not_found = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "RequestLimitExceeded")) {
        return .{ .arena = arena, .kind = .{ .request_limit_exceeded = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceInUse")) {
        return .{ .arena = arena, .kind = .{ .resource_in_use = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceLimitExceeded")) {
        return .{ .arena = arena, .kind = .{ .resource_limit_exceeded = .{
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
    if (std.mem.eql(u8, error_code, "ServiceAlreadyExists")) {
        return .{ .arena = arena, .kind = .{ .service_already_exists = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceAttributesLimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .service_attributes_limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceNotFound")) {
        return .{ .arena = arena, .kind = .{ .service_not_found = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyTagsException")) {
        return .{ .arena = arena, .kind = .{ .too_many_tags_exception = .{
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
