const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const HostPropertiesResponse = @import("host_properties_response.zig").HostPropertiesResponse;
const LogConfiguration = @import("log_configuration.zig").LogConfiguration;
const WorkerStatus = @import("worker_status.zig").WorkerStatus;

pub const GetWorkerInput = struct {
    /// The farm ID for the worker.
    farm_id: []const u8,

    /// The fleet ID of the worker.
    fleet_id: []const u8,

    /// The worker ID.
    worker_id: []const u8,

    pub const json_field_names = .{
        .farm_id = "farmId",
        .fleet_id = "fleetId",
        .worker_id = "workerId",
    };
};

pub const GetWorkerOutput = struct {
    /// The date and time the resource was created.
    created_at: i64,

    /// The user or system that created this resource.
    created_by: []const u8,

    /// The farm ID.
    farm_id: []const u8,

    /// The fleet ID.
    fleet_id: []const u8,

    /// The host properties for the worker.
    host_properties: ?HostPropertiesResponse = null,

    /// The logs for the associated worker.
    log: ?LogConfiguration = null,

    /// The status of the worker.
    status: WorkerStatus,

    /// The date and time the resource was updated.
    updated_at: ?i64 = null,

    /// The user or system that updated this resource.
    updated_by: ?[]const u8 = null,

    /// The worker ID.
    worker_id: []const u8,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .created_by = "createdBy",
        .farm_id = "farmId",
        .fleet_id = "fleetId",
        .host_properties = "hostProperties",
        .log = "log",
        .status = "status",
        .updated_at = "updatedAt",
        .updated_by = "updatedBy",
        .worker_id = "workerId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetWorkerInput, options: CallOptions) !GetWorkerOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetWorkerInput, config: *aws.Config) !aws.http.Request {
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetWorkerOutput {
    var result: GetWorkerOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetWorkerOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
