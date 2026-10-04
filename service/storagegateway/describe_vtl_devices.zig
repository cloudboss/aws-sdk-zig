const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeVTLDevicesInput, options: CallOptions) !DescribeVTLDevicesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "storagegateway", client.config.http_client.clock_skew_offset);

    var response = try client.config.http_client.sendRequestWithOptions(&request, client.options);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = try parseErrorResponse(client.allocator, response.body, response.status);
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeVTLDevicesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("storagegateway", "Storage Gateway", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
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
