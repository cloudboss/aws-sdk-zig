const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const VTLDevice = @import("vtl_device.zig").VTLDevice;

pub const DescribeVTLDevicesInput = struct {
    gateway_arn: []const u8,

    /// Specifies that the number of VTL devices described be limited to the
    /// specified
    /// number.
    limit: ?i32 = null,

    /// An opaque string that indicates the position at which to begin describing
    /// the VTL
    /// devices.
    marker: ?[]const u8 = null,

    /// An array of strings, where each string represents the Amazon Resource Name
    /// (ARN) of a
    /// VTL device.
    ///
    /// All of the specified VTL devices must be from the same gateway. If no VTL
    /// devices are
    /// specified, the result will contain all devices on the specified gateway.
    vtl_device_ar_ns: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .gateway_arn = "GatewayARN",
        .limit = "Limit",
        .marker = "Marker",
        .vtl_device_ar_ns = "VTLDeviceARNs",
    };
};

pub const DescribeVTLDevicesOutput = struct {
    gateway_arn: ?[]const u8 = null,

    /// An opaque string that indicates the position at which the VTL devices that
    /// were fetched
    /// for description ended. Use the marker in your next request to fetch the next
    /// set of VTL
    /// devices in the list. If there are no more VTL devices to describe, this
    /// field does not
    /// appear in the response.
    marker: ?[]const u8 = null,

    /// An array of VTL device objects composed of the Amazon Resource Name (ARN) of
    /// the VTL
    /// devices.
    vtl_devices: ?[]const VTLDevice = null,

    pub const json_field_names = .{
        .gateway_arn = "GatewayARN",
        .marker = "Marker",
        .vtl_devices = "VTLDevices",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeVTLDevicesInput, options: Options) !DescribeVTLDevicesOutput {
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
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeVTLDevicesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("storagegateway", "Storage Gateway", allocator);

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
    try request.headers.put(allocator, "X-Amz-Target", "StorageGateway_20130630.DescribeVTLDevices");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeVTLDevicesOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeVTLDevicesOutput, body, allocator);
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
