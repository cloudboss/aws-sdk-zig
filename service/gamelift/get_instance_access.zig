const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const InstanceAccess = @import("instance_access.zig").InstanceAccess;

pub const GetInstanceAccessInput = struct {
    /// A unique identifier for the fleet that contains the instance you want to
    /// access. You can request access to
    /// instances in EC2 fleets with the following statuses: `ACTIVATING`,
    /// `ACTIVE`, or `ERROR`. Use either a fleet ID or an ARN value.
    ///
    /// You can access fleets in `ERROR` status for a short period of time before
    /// Amazon GameLift Servers deletes them.
    fleet_id: []const u8,

    /// A unique identifier for the instance you want to access. You can access an
    /// instance in any status.
    instance_id: []const u8,

    pub const json_field_names = .{
        .fleet_id = "FleetId",
        .instance_id = "InstanceId",
    };
};

pub const GetInstanceAccessOutput = struct {
    /// The connection information for a fleet instance, including IP address and
    /// access
    /// credentials.
    instance_access: ?InstanceAccess = null,

    pub const json_field_names = .{
        .instance_access = "InstanceAccess",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetInstanceAccessInput, options: CallOptions) !GetInstanceAccessOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "gamelift", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetInstanceAccessInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("gamelift", "GameLift", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "GameLift.GetInstanceAccess");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetInstanceAccessOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetInstanceAccessOutput, body, allocator);
}
