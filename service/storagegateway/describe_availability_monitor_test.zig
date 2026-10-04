const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AvailabilityMonitorTestStatus = @import("availability_monitor_test_status.zig").AvailabilityMonitorTestStatus;

pub const DescribeAvailabilityMonitorTestInput = struct {
    gateway_arn: []const u8,

    pub const json_field_names = .{
        .gateway_arn = "GatewayARN",
    };
};

pub const DescribeAvailabilityMonitorTestOutput = struct {
    gateway_arn: ?[]const u8 = null,

    /// The time the high availability monitoring test was started. If a test hasn't
    /// been
    /// performed, the value of this field is null.
    start_time: ?i64 = null,

    /// The status of the high availability monitoring test. If a test hasn't been
    /// performed, the value of this field is null.
    status: ?AvailabilityMonitorTestStatus = null,

    pub const json_field_names = .{
        .gateway_arn = "GatewayARN",
        .start_time = "StartTime",
        .status = "Status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeAvailabilityMonitorTestInput, options: CallOptions) !DescribeAvailabilityMonitorTestOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeAvailabilityMonitorTestInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "StorageGateway_20130630.DescribeAvailabilityMonitorTest");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeAvailabilityMonitorTestOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeAvailabilityMonitorTestOutput, body, allocator);
}
