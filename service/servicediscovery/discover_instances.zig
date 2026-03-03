const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const HealthStatusFilter = @import("health_status_filter.zig").HealthStatusFilter;
const HttpInstanceSummary = @import("http_instance_summary.zig").HttpInstanceSummary;

pub const DiscoverInstancesInput = struct {
    /// The health status of the instances that you want to discover. This parameter
    /// is ignored for
    /// services that don't have a health check configured, and
    /// all
    /// instances are returned.
    ///
    /// **HEALTHY**
    ///
    /// Returns healthy instances.
    ///
    /// **UNHEALTHY**
    ///
    /// Returns unhealthy instances.
    ///
    /// **ALL**
    ///
    /// Returns all instances.
    ///
    /// **HEALTHY_OR_ELSE_ALL**
    ///
    /// Returns healthy instances, unless none are reporting a healthy state. In
    /// that case,
    /// return all instances. This is also called failing open.
    health_status: ?HealthStatusFilter = null,

    /// The maximum number of instances that you want Cloud Map to return in the
    /// response to a
    /// `DiscoverInstances` request. If you don't specify a value for
    /// `MaxResults`, Cloud Map returns up to 100 instances.
    max_results: ?i32 = null,

    /// The `HttpName` name of the namespace. The `HttpName` is
    /// found in the `HttpProperties` member of the `Properties` member of the
    /// namespace. In most cases, `Name` and `HttpName` match. However, if you
    /// reuse `Name` for namespace creation, a generated hash is added to
    /// `HttpName` to distinguish the two.
    namespace_name: []const u8,

    /// Opportunistic filters to scope the results based on custom attributes. If
    /// there are
    /// instances that match both the filters specified in both the
    /// `QueryParameters`
    /// parameter and this parameter, all of these instances are returned.
    /// Otherwise, the filters are
    /// ignored, and only instances that match the filters that are specified in the
    /// `QueryParameters` parameter are returned.
    optional_parameters: ?[]const aws.map.StringMapEntry = null,

    /// The ID of the Amazon Web Services account that owns the namespace associated
    /// with the instance, as specified in the namespace `ResourceOwner` field. For
    /// instances associated with namespaces that are shared with your account, you
    /// must specify an `OwnerAccount`.
    owner_account: ?[]const u8 = null,

    /// Filters to scope the results based on custom attributes for the instance
    /// (for example,
    /// `{version=v1, az=1a}`). Only instances that match all the specified
    /// key-value pairs
    /// are returned.
    query_parameters: ?[]const aws.map.StringMapEntry = null,

    /// The name of the service that you specified when you registered the instance.
    service_name: []const u8,

    pub const json_field_names = .{
        .health_status = "HealthStatus",
        .max_results = "MaxResults",
        .namespace_name = "NamespaceName",
        .optional_parameters = "OptionalParameters",
        .owner_account = "OwnerAccount",
        .query_parameters = "QueryParameters",
        .service_name = "ServiceName",
    };
};

pub const DiscoverInstancesOutput = struct {
    /// A complex type that contains one `HttpInstanceSummary` for each registered
    /// instance.
    instances: ?[]const HttpInstanceSummary = null,

    /// The increasing revision associated to the response Instances list. If a new
    /// instance is
    /// registered or deregistered, the `InstancesRevision` updates. The health
    /// status updates
    /// don't update `InstancesRevision`.
    instances_revision: ?i64 = null,

    pub const json_field_names = .{
        .instances = "Instances",
        .instances_revision = "InstancesRevision",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DiscoverInstancesInput, options: CallOptions) !DiscoverInstancesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DiscoverInstancesInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "Route53AutoNaming_v20170314.DiscoverInstances");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DiscoverInstancesOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DiscoverInstancesOutput, body, allocator);
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
