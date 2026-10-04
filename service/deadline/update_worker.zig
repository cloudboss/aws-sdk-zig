const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const WorkerCapabilities = @import("worker_capabilities.zig").WorkerCapabilities;
const HostPropertiesRequest = @import("host_properties_request.zig").HostPropertiesRequest;
const UpdatedWorkerStatus = @import("updated_worker_status.zig").UpdatedWorkerStatus;
const HostConfiguration = @import("host_configuration.zig").HostConfiguration;
const LogConfiguration = @import("log_configuration.zig").LogConfiguration;

pub const UpdateWorkerInput = struct {
    /// The worker capabilities to update.
    capabilities: ?WorkerCapabilities = null,

    /// The farm ID to update.
    farm_id: []const u8,

    /// The fleet ID to update.
    fleet_id: []const u8,

    /// The host properties to update.
    host_properties: ?HostPropertiesRequest = null,

    /// The worker status to update.
    status: ?UpdatedWorkerStatus = null,

    /// The worker ID to update.
    worker_id: []const u8,

    pub const json_field_names = .{
        .capabilities = "capabilities",
        .farm_id = "farmId",
        .fleet_id = "fleetId",
        .host_properties = "hostProperties",
        .status = "status",
        .worker_id = "workerId",
    };
};

pub const UpdateWorkerOutput = struct {
    /// The script that runs as a worker is starting up that you can use to provide
    /// additional configuration for workers in your fleet.
    host_configuration: ?HostConfiguration = null,

    /// The worker log to update.
    log: ?LogConfiguration = null,

    pub const json_field_names = .{
        .host_configuration = "hostConfiguration",
        .log = "log",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateWorkerInput, options: CallOptions) !UpdateWorkerOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "deadline", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateWorkerInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("deadline", "deadline", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/2023-10-12/farms/");
    try path_buf.appendSlice(allocator, input.farm_id);
    try path_buf.appendSlice(allocator, "/fleets/");
    try path_buf.appendSlice(allocator, input.fleet_id);
    try path_buf.appendSlice(allocator, "/workers/");
    try path_buf.appendSlice(allocator, input.worker_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.capabilities) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"capabilities\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.host_properties) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"hostProperties\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.status) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"status\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateWorkerOutput {
    var result: UpdateWorkerOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateWorkerOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
