const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;

pub const DescribeCacheInput = struct {
    gateway_arn: []const u8,

    pub const json_field_names = .{
        .gateway_arn = "GatewayARN",
    };
};

pub const DescribeCacheOutput = struct {
    /// The amount of cache in bytes allocated to a gateway.
    cache_allocated_in_bytes: i64 = 0,

    /// The file share's contribution to the overall percentage of the gateway's
    /// cache
    /// that has not been persisted to Amazon Web Services. The sample is taken at
    /// the end of the
    /// reporting period.
    cache_dirty_percentage: f64 = 0,

    /// Percent of application read operations from the file shares that are served
    /// from cache.
    /// The sample is taken at the end of the reporting period.
    cache_hit_percentage: f64 = 0,

    /// Percent of application read operations from the file shares that are not
    /// served from
    /// cache. The sample is taken at the end of the reporting period.
    cache_miss_percentage: f64 = 0,

    /// Percent use of the gateway's cache storage. This metric applies only to the
    /// gateway-cached volume setup. The sample is taken at the end of the reporting
    /// period.
    cache_used_percentage: f64 = 0,

    /// An array of strings that identify disks that are to be configured as working
    /// storage.
    /// Each string has a minimum length of 1 and maximum length of 300. You can get
    /// the disk IDs
    /// from the ListLocalDisks API.
    disk_ids: ?[]const []const u8 = null,

    gateway_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .cache_allocated_in_bytes = "CacheAllocatedInBytes",
        .cache_dirty_percentage = "CacheDirtyPercentage",
        .cache_hit_percentage = "CacheHitPercentage",
        .cache_miss_percentage = "CacheMissPercentage",
        .cache_used_percentage = "CacheUsedPercentage",
        .disk_ids = "DiskIds",
        .gateway_arn = "GatewayARN",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeCacheInput, options: Options) !DescribeCacheOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "storagegateway");

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

fn serializeRequest(alloc: std.mem.Allocator, input: DescribeCacheInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("storagegateway", "Storage Gateway", alloc);

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
    try request.headers.put(alloc, "X-Amz-Target", "StorageGateway_20130630.DescribeCache");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !DescribeCacheOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeCacheOutput, body, alloc);
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

    if (std.mem.eql(u8, error_code, "InternalServerError")) {
        return .{ .arena = arena, .kind = .{ .internal_server_error = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidGatewayRequestException")) {
        return .{ .arena = arena, .kind = .{ .invalid_gateway_request_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceUnavailableError")) {
        return .{ .arena = arena, .kind = .{ .service_unavailable_error = .{
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
