const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const LoRaWANDevice = @import("lo_ra_wan_device.zig").LoRaWANDevice;
const PositioningConfigStatus = @import("positioning_config_status.zig").PositioningConfigStatus;
const SidewalkCreateWirelessDevice = @import("sidewalk_create_wireless_device.zig").SidewalkCreateWirelessDevice;
const Tag = @import("tag.zig").Tag;
const WirelessDeviceType = @import("wireless_device_type.zig").WirelessDeviceType;

pub const CreateWirelessDeviceInput = struct {
    /// Each resource must have a unique client request token. The client token is
    /// used to
    /// implement idempotency. It ensures that the request completes no more than
    /// one time. If
    /// you retry a request with the same token and the same parameters, the request
    /// will
    /// complete successfully. However, if you try to create a new resource using
    /// the same token
    /// but different parameters, an HTTP 409 conflict occurs. If you omit this
    /// value, AWS SDKs
    /// will automatically generate a unique client request. For more information
    /// about
    /// idempotency, see [Ensuring idempotency in Amazon
    /// EC2 API
    /// requests](https://docs.aws.amazon.com/ec2/latest/devguide/ec2-api-idempotency.html).
    client_request_token: ?[]const u8 = null,

    /// The description of the new resource.
    description: ?[]const u8 = null,

    /// The name of the destination to assign to the new wireless device.
    destination_name: []const u8,

    /// The device configuration information to use to create the wireless device.
    lo_ra_wan: ?LoRaWANDevice = null,

    /// The name of the new resource.
    ///
    /// The following special characters aren't accepted: `<>^#~$`
    name: ?[]const u8 = null,

    /// The integration status of the Device Location feature for LoRaWAN and
    /// Sidewalk devices.
    positioning: ?PositioningConfigStatus = null,

    /// The device configuration information to use to create the Sidewalk device.
    sidewalk: ?SidewalkCreateWirelessDevice = null,

    /// The tags to attach to the new wireless device. Tags are metadata that you
    /// can use to
    /// manage a resource.
    tags: ?[]const Tag = null,

    /// The wireless device type.
    type: WirelessDeviceType,

    pub const json_field_names = .{
        .client_request_token = "ClientRequestToken",
        .description = "Description",
        .destination_name = "DestinationName",
        .lo_ra_wan = "LoRaWAN",
        .name = "Name",
        .positioning = "Positioning",
        .sidewalk = "Sidewalk",
        .tags = "Tags",
        .type = "Type",
    };
};

pub const CreateWirelessDeviceOutput = struct {
    /// The Amazon Resource Name of the new resource.
    arn: ?[]const u8 = null,

    /// The ID of the new wireless device.
    id: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .id = "Id",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateWirelessDeviceInput, options: CallOptions) !CreateWirelessDeviceOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "iotwireless", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateWirelessDeviceInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("api.iotwireless", "IoT Wireless", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/wireless-devices";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.client_request_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ClientRequestToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"DestinationName\":");
    try aws.json.writeValue(@TypeOf(input.destination_name), input.destination_name, allocator, &body_buf);
    has_prev = true;
    if (input.lo_ra_wan) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"LoRaWAN\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Name\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.positioning) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Positioning\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.sidewalk) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Sidewalk\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Type\":");
    try aws.json.writeValue(@TypeOf(input.type), input.type, allocator, &body_buf);
    has_prev = true;

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateWirelessDeviceOutput {
    const result: CreateWirelessDeviceOutput = try aws.json.parseJsonObject(
        CreateWirelessDeviceOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
