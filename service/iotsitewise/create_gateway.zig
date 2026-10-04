const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const GatewayPlatform = @import("gateway_platform.zig").GatewayPlatform;

pub const CreateGatewayInput = struct {
    /// A unique name for the gateway.
    gateway_name: []const u8,

    /// The gateway's platform. You can only specify one platform in a gateway.
    gateway_platform: GatewayPlatform,

    /// The version of the gateway to create. Specify `3` to create an MQTT-enabled,
    /// V3
    /// gateway and `2` to create a Classic streams, V2 gateway. If not specified,
    /// the
    /// default is `2` (Classic streams, V2 gateway).
    ///
    /// When creating a V3 gateway (`gatewayVersion=3`) with the
    /// `GreengrassV2` platform, you must also specify the
    /// `coreDeviceOperatingSystem` parameter.
    ///
    /// We recommend creating an MQTT-enabled gateway for self-hosted gateways and
    /// Siemens
    /// Industrial Edge gateways. For more information on gateway versions, see [Use
    /// Amazon Web Services IoT SiteWise Edge Edge
    /// gateways](https://docs.aws.amazon.com/iot-sitewise/latest/userguide/gateways.html).
    gateway_version: ?[]const u8 = null,

    /// A list of key-value pairs that contain metadata for the gateway. For more
    /// information, see
    /// [Tagging your IoT SiteWise
    /// resources](https://docs.aws.amazon.com/iot-sitewise/latest/userguide/tag-resources.html) in the *IoT SiteWise User Guide*.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .gateway_name = "gatewayName",
        .gateway_platform = "gatewayPlatform",
        .gateway_version = "gatewayVersion",
        .tags = "tags",
    };
};

pub const CreateGatewayOutput = struct {
    /// The
    /// [ARN](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) of the gateway, which has the following format.
    ///
    /// `arn:${Partition}:iotsitewise:${Region}:${Account}:gateway/${GatewayId}`
    gateway_arn: []const u8,

    /// The ID of the gateway device. You can use this ID when you call other IoT
    /// SiteWise API operations.
    gateway_id: []const u8,

    pub const json_field_names = .{
        .gateway_arn = "gatewayArn",
        .gateway_id = "gatewayId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateGatewayInput, options: CallOptions) !CreateGatewayOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateGatewayInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iotsitewise", "IoTSiteWise", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/20200301/gateways";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"gatewayName\":");
    try aws.json.writeValue(@TypeOf(input.gateway_name), input.gateway_name, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"gatewayPlatform\":");
    try aws.json.writeValue(@TypeOf(input.gateway_platform), input.gateway_platform, allocator, &body_buf);
    has_prev = true;
    if (input.gateway_version) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"gatewayVersion\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateGatewayOutput {
    var result: CreateGatewayOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateGatewayOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
