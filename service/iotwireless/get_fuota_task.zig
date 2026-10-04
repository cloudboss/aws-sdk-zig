const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const LoRaWANFuotaTaskGetInfo = @import("lo_ra_wan_fuota_task_get_info.zig").LoRaWANFuotaTaskGetInfo;
const FuotaTaskStatus = @import("fuota_task_status.zig").FuotaTaskStatus;

pub const GetFuotaTaskInput = struct {
    id: []const u8,

    pub const json_field_names = .{
        .id = "Id",
    };
};

pub const GetFuotaTaskOutput = struct {
    arn: ?[]const u8 = null,

    created_at: ?i64 = null,

    description: ?[]const u8 = null,

    descriptor: ?[]const u8 = null,

    firmware_update_image: ?[]const u8 = null,

    firmware_update_role: ?[]const u8 = null,

    fragment_interval_ms: ?i32 = null,

    fragment_size_bytes: ?i32 = null,

    id: ?[]const u8 = null,

    lo_ra_wan: ?LoRaWANFuotaTaskGetInfo = null,

    name: ?[]const u8 = null,

    redundancy_percent: ?i32 = null,

    status: ?FuotaTaskStatus = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .created_at = "CreatedAt",
        .description = "Description",
        .descriptor = "Descriptor",
        .firmware_update_image = "FirmwareUpdateImage",
        .firmware_update_role = "FirmwareUpdateRole",
        .fragment_interval_ms = "FragmentIntervalMS",
        .fragment_size_bytes = "FragmentSizeBytes",
        .id = "Id",
        .lo_ra_wan = "LoRaWAN",
        .name = "Name",
        .redundancy_percent = "RedundancyPercent",
        .status = "Status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetFuotaTaskInput, options: CallOptions) !GetFuotaTaskOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetFuotaTaskInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("api.iotwireless", "IoT Wireless", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/fuota-tasks/");
    try path_buf.appendSlice(allocator, input.id);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetFuotaTaskOutput {
    var result: GetFuotaTaskOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetFuotaTaskOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
