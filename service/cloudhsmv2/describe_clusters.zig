const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const Cluster = @import("cluster.zig").Cluster;

pub const DescribeClustersInput = struct {
    /// One or more filters to limit the items returned in the response.
    ///
    /// Use the `clusterIds` filter to return only the specified clusters. Specify
    /// clusters by their cluster identifier (ID).
    ///
    /// Use the `vpcIds` filter to return only the clusters in the specified virtual
    /// private clouds (VPCs). Specify VPCs by their VPC identifier (ID).
    ///
    /// Use the `states` filter to return only clusters that match the specified
    /// state.
    filters: ?[]const aws.map.MapEntry([]const []const u8) = null,

    /// The maximum number of clusters to return in the response. When there are
    /// more clusters
    /// than the number you specify, the response contains a `NextToken` value.
    max_results: ?i32 = null,

    /// The `NextToken` value that you received in the previous response. Use this
    /// value to get more clusters.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .filters = "Filters",
        .max_results = "MaxResults",
        .next_token = "NextToken",
    };
};

pub const DescribeClustersOutput = struct {
    /// A list of clusters.
    clusters: ?[]const Cluster = null,

    /// An opaque string that indicates that the response contains only a subset of
    /// clusters.
    /// Use this value in a subsequent `DescribeClusters` request to get more
    /// clusters.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .clusters = "Clusters",
        .next_token = "NextToken",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeClustersInput, options: Options) !DescribeClustersOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "cloudhsmv2");

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeClustersInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cloudhsmv2", "CloudHSM V2", allocator);

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
    try request.headers.put(allocator, "X-Amz-Target", "BaldrApiService.DescribeClusters");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeClustersOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeClustersOutput, body, allocator);
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

    if (std.mem.eql(u8, error_code, "CloudHsmAccessDeniedException")) {
        return .{ .arena = arena, .kind = .{ .cloud_hsm_access_denied_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CloudHsmInternalFailureException")) {
        return .{ .arena = arena, .kind = .{ .cloud_hsm_internal_failure_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CloudHsmInvalidRequestException")) {
        return .{ .arena = arena, .kind = .{ .cloud_hsm_invalid_request_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CloudHsmResourceLimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .cloud_hsm_resource_limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CloudHsmResourceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .cloud_hsm_resource_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CloudHsmServiceException")) {
        return .{ .arena = arena, .kind = .{ .cloud_hsm_service_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CloudHsmTagException")) {
        return .{ .arena = arena, .kind = .{ .cloud_hsm_tag_exception = .{
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
