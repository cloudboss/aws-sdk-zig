const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const LoRaWANFuotaTask = @import("lo_ra_wan_fuota_task.zig").LoRaWANFuotaTask;
const Tag = @import("tag.zig").Tag;

pub const CreateFuotaTaskInput = struct {
    client_request_token: ?[]const u8 = null,

    description: ?[]const u8 = null,

    descriptor: ?[]const u8 = null,

    firmware_update_image: []const u8,

    firmware_update_role: []const u8,

    fragment_interval_ms: ?i32 = null,

    fragment_size_bytes: ?i32 = null,

    lo_ra_wan: ?LoRaWANFuotaTask = null,

    name: ?[]const u8 = null,

    redundancy_percent: ?i32 = null,

    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .client_request_token = "ClientRequestToken",
        .description = "Description",
        .descriptor = "Descriptor",
        .firmware_update_image = "FirmwareUpdateImage",
        .firmware_update_role = "FirmwareUpdateRole",
        .fragment_interval_ms = "FragmentIntervalMS",
        .fragment_size_bytes = "FragmentSizeBytes",
        .lo_ra_wan = "LoRaWAN",
        .name = "Name",
        .redundancy_percent = "RedundancyPercent",
        .tags = "Tags",
    };
};

pub const CreateFuotaTaskOutput = struct {
    arn: ?[]const u8 = null,

    id: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .id = "Id",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateFuotaTaskInput, options: CallOptions) !CreateFuotaTaskOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateFuotaTaskInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("api.iotwireless", "IoT Wireless", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/fuota-tasks";

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
    if (input.descriptor) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Descriptor\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"FirmwareUpdateImage\":");
    try aws.json.writeValue(@TypeOf(input.firmware_update_image), input.firmware_update_image, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"FirmwareUpdateRole\":");
    try aws.json.writeValue(@TypeOf(input.firmware_update_role), input.firmware_update_role, allocator, &body_buf);
    has_prev = true;
    if (input.fragment_interval_ms) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"FragmentIntervalMS\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.fragment_size_bytes) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"FragmentSizeBytes\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
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
    if (input.redundancy_percent) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"RedundancyPercent\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateFuotaTaskOutput {
    var result: CreateFuotaTaskOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateFuotaTaskOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
