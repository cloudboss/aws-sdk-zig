const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CloudWatchLogDeliveryOptions = @import("cloud_watch_log_delivery_options.zig").CloudWatchLogDeliveryOptions;

pub const GetLoggingOptionsInput = struct {};

pub const GetLoggingOptionsOutput = struct {
    /// Returns information about log delivery to Amazon CloudWatch Logs.
    cloud_watch_log_delivery: ?CloudWatchLogDeliveryOptions = null,

    pub const json_field_names = .{
        .cloud_watch_log_delivery = "cloudWatchLogDelivery",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetLoggingOptionsInput, options: CallOptions) !GetLoggingOptionsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "iotfleetwise", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetLoggingOptionsInput, config: *aws.Config) !aws.http.Request {
    _ = input;
    const endpoint = try config.getEndpointForService("iotfleetwise", "IoTFleetWise", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = "{}";

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "IoTAutobahnControlPlane.GetLoggingOptions");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetLoggingOptionsOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(GetLoggingOptionsOutput, body, allocator);
}
