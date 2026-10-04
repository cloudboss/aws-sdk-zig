const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PositioningConfigStatus = @import("positioning_config_status.zig").PositioningConfigStatus;
const SidewalkSingleStartImportInfo = @import("sidewalk_single_start_import_info.zig").SidewalkSingleStartImportInfo;
const Tag = @import("tag.zig").Tag;

pub const StartSingleWirelessDeviceImportTaskInput = struct {
    client_request_token: ?[]const u8 = null,

    /// The name of the Sidewalk destination that describes the IoT rule to route
    /// messages
    /// from the device in the import task that will be onboarded to AWS IoT
    /// Wireless.
    destination_name: []const u8,

    /// The name of the wireless device for which an import task is being started.
    device_name: ?[]const u8 = null,

    /// The integration status of the Device Location feature for Sidewalk devices.
    positioning: ?PositioningConfigStatus = null,

    /// The Sidewalk-related parameters for importing a single wireless device.
    sidewalk: SidewalkSingleStartImportInfo,

    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .client_request_token = "ClientRequestToken",
        .destination_name = "DestinationName",
        .device_name = "DeviceName",
        .positioning = "Positioning",
        .sidewalk = "Sidewalk",
        .tags = "Tags",
    };
};

pub const StartSingleWirelessDeviceImportTaskOutput = struct {
    /// The ARN (Amazon Resource Name) of the import task.
    arn: ?[]const u8 = null,

    /// The import task ID.
    id: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .id = "Id",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartSingleWirelessDeviceImportTaskInput, options: CallOptions) !StartSingleWirelessDeviceImportTaskOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: StartSingleWirelessDeviceImportTaskInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("api.iotwireless", "IoT Wireless", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/wireless_single_device_import_task";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.client_request_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ClientRequestToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"DestinationName\":");
    try aws.json.writeValue(@TypeOf(input.destination_name), input.destination_name, allocator, &body_buf);
    has_prev = true;
    if (input.device_name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"DeviceName\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.positioning) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Positioning\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Sidewalk\":");
    try aws.json.writeValue(@TypeOf(input.sidewalk), input.sidewalk, allocator, &body_buf);
    has_prev = true;
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Tags\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartSingleWirelessDeviceImportTaskOutput {
    const result: StartSingleWirelessDeviceImportTaskOutput = try aws.json.parseJsonObject(
        StartSingleWirelessDeviceImportTaskOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
