const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const FleetAction = @import("fleet_action.zig").FleetAction;

pub const StopFleetActionsInput = struct {
    /// List of actions to suspend on the fleet.
    actions: []const FleetAction,

    /// A unique identifier for the fleet to stop actions on. You can use either the
    /// fleet ID or ARN value.
    fleet_id: []const u8,

    /// The fleet location to stop fleet actions for. Specify a location in the form
    /// of an
    /// Amazon Web Services Region code, such as `us-west-2`.
    location: ?[]const u8 = null,

    pub const json_field_names = .{
        .actions = "Actions",
        .fleet_id = "FleetId",
        .location = "Location",
    };
};

pub const StopFleetActionsOutput = struct {
    /// The Amazon Resource Name
    /// ([ARN](https://docs.aws.amazon.com/AmazonS3/latest/dev/s3-arn-format.html))
    /// that is assigned to a Amazon GameLift Servers fleet resource and uniquely
    /// identifies it. ARNs are unique across all Regions. Format is
    /// `arn:aws:gamelift:::fleet/fleet-a1234567-b8c9-0d1e-2fa3-b45c6d7e8912`.
    fleet_arn: ?[]const u8 = null,

    /// A unique identifier for the fleet to stop actions on.
    fleet_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .fleet_arn = "FleetArn",
        .fleet_id = "FleetId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StopFleetActionsInput, options: CallOptions) !StopFleetActionsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: StopFleetActionsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "GameLift.StopFleetActions");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StopFleetActionsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(StopFleetActionsOutput, body, allocator);
}
