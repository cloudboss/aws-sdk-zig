const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const BatchDeleteDevicePositionHistoryError = @import("batch_delete_device_position_history_error.zig").BatchDeleteDevicePositionHistoryError;

pub const BatchDeleteDevicePositionHistoryInput = struct {
    /// Devices whose position history you want to delete.
    ///
    /// * For example, for two devices: `“DeviceIds” : [DeviceId1,DeviceId2]`
    device_ids: []const []const u8,

    /// The name of the tracker resource to delete the device position history from.
    tracker_name: []const u8,

    pub const json_field_names = .{
        .device_ids = "DeviceIds",
        .tracker_name = "TrackerName",
    };
};

pub const BatchDeleteDevicePositionHistoryOutput = struct {
    /// Contains error details for each device history that failed to delete.
    errors: ?[]const BatchDeleteDevicePositionHistoryError = null,

    pub const json_field_names = .{
        .errors = "Errors",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: BatchDeleteDevicePositionHistoryInput, options: CallOptions) !BatchDeleteDevicePositionHistoryOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "geo", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: BatchDeleteDevicePositionHistoryInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("geo", "Location", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/tracking/v0/trackers/");
    try path_buf.appendSlice(allocator, input.tracker_name);
    try path_buf.appendSlice(allocator, "/delete-positions");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"DeviceIds\":");
    try aws.json.writeValue(@TypeOf(input.device_ids), input.device_ids, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !BatchDeleteDevicePositionHistoryOutput {
    const result: BatchDeleteDevicePositionHistoryOutput = try aws.json.parseJsonObject(
        BatchDeleteDevicePositionHistoryOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
