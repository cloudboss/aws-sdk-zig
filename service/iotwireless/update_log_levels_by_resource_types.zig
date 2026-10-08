const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const LogLevel = @import("log_level.zig").LogLevel;
const FuotaTaskLogOption = @import("fuota_task_log_option.zig").FuotaTaskLogOption;
const WirelessDeviceLogOption = @import("wireless_device_log_option.zig").WirelessDeviceLogOption;
const WirelessGatewayLogOption = @import("wireless_gateway_log_option.zig").WirelessGatewayLogOption;

pub const UpdateLogLevelsByResourceTypesInput = struct {
    default_log_level: ?LogLevel = null,

    fuota_task_log_options: ?[]const FuotaTaskLogOption = null,

    wireless_device_log_options: ?[]const WirelessDeviceLogOption = null,

    wireless_gateway_log_options: ?[]const WirelessGatewayLogOption = null,

    pub const json_field_names = .{
        .default_log_level = "DefaultLogLevel",
        .fuota_task_log_options = "FuotaTaskLogOptions",
        .wireless_device_log_options = "WirelessDeviceLogOptions",
        .wireless_gateway_log_options = "WirelessGatewayLogOptions",
    };
};

pub const UpdateLogLevelsByResourceTypesOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateLogLevelsByResourceTypesInput, options: CallOptions) !UpdateLogLevelsByResourceTypesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateLogLevelsByResourceTypesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("api.iotwireless", "IoT Wireless", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/log-levels";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.default_log_level) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"DefaultLogLevel\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.fuota_task_log_options) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"FuotaTaskLogOptions\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.wireless_device_log_options) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"WirelessDeviceLogOptions\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.wireless_gateway_log_options) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"WirelessGatewayLogOptions\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateLogLevelsByResourceTypesOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: UpdateLogLevelsByResourceTypesOutput = .{};

    return result;
}
