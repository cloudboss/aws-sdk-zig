const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const ListServiceInstancesFilter = @import("list_service_instances_filter.zig").ListServiceInstancesFilter;
const ListServiceInstancesSortBy = @import("list_service_instances_sort_by.zig").ListServiceInstancesSortBy;
const SortOrder = @import("sort_order.zig").SortOrder;
const ServiceInstanceSummary = @import("service_instance_summary.zig").ServiceInstanceSummary;

pub const ListServiceInstancesInput = struct {
    /// An array of filtering criteria that scope down the result list. By default,
    /// all service
    /// instances in the Amazon Web Services account are returned.
    filters: ?[]const ListServiceInstancesFilter = null,

    /// The maximum number of service instances to list.
    max_results: ?i32 = null,

    /// A token that indicates the location of the next service in the array of
    /// service instances,
    /// after the list of service instances that was previously requested.
    next_token: ?[]const u8 = null,

    /// The name of the service that the service instance belongs to.
    service_name: ?[]const u8 = null,

    /// The field that the result list is sorted by.
    ///
    /// When you choose to sort by `serviceName`, service instances within each
    /// service
    /// are sorted by service instance name.
    ///
    /// Default: `serviceName`
    sort_by: ?ListServiceInstancesSortBy = null,

    /// Result list sort order.
    ///
    /// Default: `ASCENDING`
    sort_order: ?SortOrder = null,

    pub const json_field_names = .{
        .filters = "filters",
        .max_results = "maxResults",
        .next_token = "nextToken",
        .service_name = "serviceName",
        .sort_by = "sortBy",
        .sort_order = "sortOrder",
    };
};

pub const ListServiceInstancesOutput = struct {
    /// A token that indicates the location of the next service instance in the
    /// array of service
    /// instances, after the current requested list of service instances.
    next_token: ?[]const u8 = null,

    /// An array of service instances with summary data.
    service_instances: ?[]const ServiceInstanceSummary = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .service_instances = "serviceInstances",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListServiceInstancesInput, options: CallOptions) !ListServiceInstancesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "awsproton20200720");

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListServiceInstancesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("proton", "Proton", allocator);

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
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "AwsProton20200720.ListServiceInstances");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListServiceInstancesOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(ListServiceInstancesOutput, body, allocator);
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
    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServerException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_exception = .{
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
    if (std.mem.eql(u8, error_code, "ServiceQuotaExceededException")) {
        return .{ .arena = arena, .kind = .{ .service_quota_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ThrottlingException")) {
        return .{ .arena = arena, .kind = .{ .throttling_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ValidationException")) {
        return .{ .arena = arena, .kind = .{ .validation_exception = .{
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
