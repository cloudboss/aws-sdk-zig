const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const TapeArchive = @import("tape_archive.zig").TapeArchive;

pub const DescribeTapeArchivesInput = struct {
    /// Specifies that the number of virtual tapes described be limited to the
    /// specified
    /// number.
    limit: ?i32 = null,

    /// An opaque string that indicates the position at which to begin describing
    /// virtual
    /// tapes.
    marker: ?[]const u8 = null,

    /// Specifies one or more unique Amazon Resource Names (ARNs) that represent the
    /// virtual
    /// tapes you want to describe.
    tape_ar_ns: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .limit = "Limit",
        .marker = "Marker",
        .tape_ar_ns = "TapeARNs",
    };
};

pub const DescribeTapeArchivesOutput = struct {
    /// An opaque string that indicates the position at which the virtual tapes that
    /// were
    /// fetched for description ended. Use this marker in your next request to fetch
    /// the next set
    /// of virtual tapes in the virtual tape shelf (VTS). If there are no more
    /// virtual tapes to
    /// describe, this field does not appear in the response.
    marker: ?[]const u8 = null,

    /// An array of virtual tape objects in the virtual tape shelf (VTS). The
    /// description
    /// includes of the Amazon Resource Name (ARN) of the virtual tapes. The
    /// information returned
    /// includes the Amazon Resource Names (ARNs) of the tapes, size of the tapes,
    /// status of the
    /// tapes, progress of the description, and tape barcode.
    tape_archives: ?[]const TapeArchive = null,

    pub const json_field_names = .{
        .marker = "Marker",
        .tape_archives = "TapeArchives",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeTapeArchivesInput, options: Options) !DescribeTapeArchivesOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: DescribeTapeArchivesInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(alloc, "X-Amz-Target", "StorageGateway_20130630.DescribeTapeArchives");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !DescribeTapeArchivesOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeTapeArchivesOutput, body, alloc);
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
