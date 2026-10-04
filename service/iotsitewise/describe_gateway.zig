const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const GatewayCapabilitySummary = @import("gateway_capability_summary.zig").GatewayCapabilitySummary;
const GatewayPlatform = @import("gateway_platform.zig").GatewayPlatform;

pub const DescribeGatewayInput = struct {
    /// The ID of the gateway device.
    gateway_id: []const u8,

    pub const json_field_names = .{
        .gateway_id = "gatewayId",
    };
};

pub const DescribeGatewayOutput = struct {
    /// The date the gateway was created, in Unix epoch time.
    creation_date: i64,

    /// The
    /// [ARN](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) of the gateway, which has the following format.
    ///
    /// `arn:${Partition}:iotsitewise:${Region}:${Account}:gateway/${GatewayId}`
    gateway_arn: []const u8,

    /// A list of gateway capability summaries that each contain a namespace and
    /// status. Each
    /// gateway capability defines data sources for the gateway. To retrieve a
    /// capability
    /// configuration's definition, use
    /// [DescribeGatewayCapabilityConfiguration](https://docs.aws.amazon.com/iot-sitewise/latest/APIReference/API_DescribeGatewayCapabilityConfiguration.html).
    gateway_capability_summaries: ?[]const GatewayCapabilitySummary = null,

    /// The ID of the gateway device.
    gateway_id: []const u8,

    /// The name of the gateway.
    gateway_name: []const u8,

    /// The gateway's platform.
    gateway_platform: ?GatewayPlatform = null,

    /// The version of the gateway. A value of `3` indicates an MQTT-enabled, V3
    /// gateway, while `2` indicates a Classic streams, V2 gateway.
    gateway_version: ?[]const u8 = null,

    /// The date the gateway was last updated, in Unix epoch time.
    last_update_date: i64,

    pub const json_field_names = .{
        .creation_date = "creationDate",
        .gateway_arn = "gatewayArn",
        .gateway_capability_summaries = "gatewayCapabilitySummaries",
        .gateway_id = "gatewayId",
        .gateway_name = "gatewayName",
        .gateway_platform = "gatewayPlatform",
        .gateway_version = "gatewayVersion",
        .last_update_date = "lastUpdateDate",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeGatewayInput, options: CallOptions) !DescribeGatewayOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "iotsitewise", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeGatewayInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iotsitewise", "IoTSiteWise", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/20200301/gateways/");
    try path_buf.appendSlice(allocator, input.gateway_id);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeGatewayOutput {
    const result: DescribeGatewayOutput = try aws.json.parseJsonObject(
        DescribeGatewayOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
