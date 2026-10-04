const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AutoScalingStatus = @import("auto_scaling_status.zig").AutoScalingStatus;
const FleetCapabilities = @import("fleet_capabilities.zig").FleetCapabilities;
const FleetConfiguration = @import("fleet_configuration.zig").FleetConfiguration;
const HostConfiguration = @import("host_configuration.zig").HostConfiguration;
const FleetStatus = @import("fleet_status.zig").FleetStatus;

pub const GetFleetInput = struct {
    /// The farm ID of the farm in the fleet.
    farm_id: []const u8,

    /// The fleet ID of the fleet to get.
    fleet_id: []const u8,

    pub const json_field_names = .{
        .farm_id = "farmId",
        .fleet_id = "fleetId",
    };
};

pub const GetFleetOutput = struct {
    /// The Auto Scaling status of the fleet. Either `GROWING`, `STEADY`, or
    /// `SHRINKING`.
    auto_scaling_status: ?AutoScalingStatus = null,

    /// Outlines what the fleet is capable of for minimums, maximums, and naming, in
    /// addition to attribute names and values.
    capabilities: ?FleetCapabilities = null,

    /// The configuration setting for the fleet.
    configuration: ?FleetConfiguration = null,

    /// The date and time the resource was created.
    created_at: i64,

    /// The user or system that created this resource.
    created_by: []const u8,

    /// The description of the fleet.
    ///
    /// This field can store any content. Escape or encode this content before
    /// displaying it on a webpage or any other system that might interpret the
    /// content of this field.
    description: ?[]const u8 = null,

    /// The display name of the fleet.
    ///
    /// This field can store any content. Escape or encode this content before
    /// displaying it on a webpage or any other system that might interpret the
    /// content of this field.
    display_name: []const u8,

    /// The farm ID of the farm in the fleet.
    farm_id: []const u8,

    /// The fleet ID.
    fleet_id: []const u8,

    /// The script that runs as a worker is starting up that you can use to provide
    /// additional configuration for workers in your fleet.
    host_configuration: ?HostConfiguration = null,

    /// The maximum number of workers specified in the fleet.
    max_worker_count: i32,

    /// The minimum number of workers specified in the fleet.
    min_worker_count: i32,

    /// The IAM role ARN.
    role_arn: []const u8,

    /// The status of the fleet.
    status: FleetStatus,

    /// A message that communicates a suspended status of the fleet.
    status_message: ?[]const u8 = null,

    /// The number of target workers in the fleet.
    target_worker_count: ?i32 = null,

    /// The date and time the resource was updated.
    updated_at: ?i64 = null,

    /// The user or system that updated this resource.
    updated_by: ?[]const u8 = null,

    /// The number of workers in the fleet.
    worker_count: i32,

    pub const json_field_names = .{
        .auto_scaling_status = "autoScalingStatus",
        .capabilities = "capabilities",
        .configuration = "configuration",
        .created_at = "createdAt",
        .created_by = "createdBy",
        .description = "description",
        .display_name = "displayName",
        .farm_id = "farmId",
        .fleet_id = "fleetId",
        .host_configuration = "hostConfiguration",
        .max_worker_count = "maxWorkerCount",
        .min_worker_count = "minWorkerCount",
        .role_arn = "roleArn",
        .status = "status",
        .status_message = "statusMessage",
        .target_worker_count = "targetWorkerCount",
        .updated_at = "updatedAt",
        .updated_by = "updatedBy",
        .worker_count = "workerCount",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetFleetInput, options: CallOptions) !GetFleetOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetFleetInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("deadline", "deadline", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/2023-10-12/farms/");
    try path_buf.appendSlice(allocator, input.farm_id);
    try path_buf.appendSlice(allocator, "/fleets/");
    try path_buf.appendSlice(allocator, input.fleet_id);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetFleetOutput {
    var result: GetFleetOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetFleetOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
