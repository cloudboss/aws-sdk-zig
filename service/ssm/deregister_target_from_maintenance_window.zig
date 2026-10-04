const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const DeregisterTargetFromMaintenanceWindowInput = struct {
    /// The system checks if the target is being referenced by a task. If the target
    /// is being
    /// referenced, the system returns an error and doesn't deregister the target
    /// from the maintenance
    /// window.
    safe: ?bool = null,

    /// The ID of the maintenance window the target should be removed from.
    window_id: []const u8,

    /// The ID of the target definition to remove.
    window_target_id: []const u8,

    pub const json_field_names = .{
        .safe = "Safe",
        .window_id = "WindowId",
        .window_target_id = "WindowTargetId",
    };
};

pub const DeregisterTargetFromMaintenanceWindowOutput = struct {
    /// The ID of the maintenance window the target was removed from.
    window_id: ?[]const u8 = null,

    /// The ID of the removed target definition.
    window_target_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .window_id = "WindowId",
        .window_target_id = "WindowTargetId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeregisterTargetFromMaintenanceWindowInput, options: CallOptions) !DeregisterTargetFromMaintenanceWindowOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ssm", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DeregisterTargetFromMaintenanceWindowInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ssm", "SSM", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AmazonSSM.DeregisterTargetFromMaintenanceWindow");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeregisterTargetFromMaintenanceWindowOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DeregisterTargetFromMaintenanceWindowOutput, body, allocator);
}
