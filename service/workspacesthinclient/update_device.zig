const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SoftwareSetUpdateSchedule = @import("software_set_update_schedule.zig").SoftwareSetUpdateSchedule;
const DeviceSummary = @import("device_summary.zig").DeviceSummary;

pub const UpdateDeviceInput = struct {
    /// The ID of the software set to apply.
    desired_software_set_id: ?[]const u8 = null,

    /// The ID of the device to update.
    id: []const u8,

    /// The name of the device to update.
    name: ?[]const u8 = null,

    /// An option to define if software updates should be applied within a
    /// maintenance window.
    software_set_update_schedule: ?SoftwareSetUpdateSchedule = null,

    pub const json_field_names = .{
        .desired_software_set_id = "desiredSoftwareSetId",
        .id = "id",
        .name = "name",
        .software_set_update_schedule = "softwareSetUpdateSchedule",
    };
};

pub const UpdateDeviceOutput = struct {
    /// Describes a device.
    device: ?DeviceSummary = null,

    pub const json_field_names = .{
        .device = "device",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateDeviceInput, options: CallOptions) !UpdateDeviceOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "thinclient", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateDeviceInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("thinclient", "WorkSpaces Thin Client", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/devices/");
    try path_buf.appendSlice(allocator, input.id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.desired_software_set_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"desiredSoftwareSetId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"name\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.software_set_update_schedule) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"softwareSetUpdateSchedule\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PATCH;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateDeviceOutput {
    var result: UpdateDeviceOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateDeviceOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
