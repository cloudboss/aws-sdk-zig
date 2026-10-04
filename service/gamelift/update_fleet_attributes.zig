const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AnywhereConfiguration = @import("anywhere_configuration.zig").AnywhereConfiguration;
const ProtectionPolicy = @import("protection_policy.zig").ProtectionPolicy;
const ResourceCreationLimitPolicy = @import("resource_creation_limit_policy.zig").ResourceCreationLimitPolicy;

pub const UpdateFleetAttributesInput = struct {
    /// Amazon GameLift Servers Anywhere configuration options.
    anywhere_configuration: ?AnywhereConfiguration = null,

    /// A human-readable description of a fleet.
    description: ?[]const u8 = null,

    /// A unique identifier for the fleet to update attribute metadata for. You can
    /// use either the fleet ID or ARN
    /// value.
    fleet_id: []const u8,

    /// The name of a metric group to add this fleet to. Use a metric group in
    /// Amazon
    /// CloudWatch to aggregate the metrics from multiple fleets. Provide an
    /// existing metric
    /// group name, or create a new metric group by providing a new name. A fleet
    /// can only be in
    /// one metric group at a time.
    metric_groups: ?[]const []const u8 = null,

    /// A descriptive label that is associated with a fleet. Fleet names do not need
    /// to be unique.
    name: ?[]const u8 = null,

    /// The game session protection policy to apply to all new game sessions created
    /// in this
    /// fleet. Game sessions that already exist are not affected. You can set
    /// protection for
    /// individual game sessions using
    /// [UpdateGameSession](https://docs.aws.amazon.com/gamelift/latest/apireference/API_UpdateGameSession.html) .
    ///
    /// * **NoProtection** -- The game session can be
    /// terminated during a scale-down event.
    ///
    /// * **FullProtection** -- If the game session is in an
    /// `ACTIVE` status, it cannot be terminated during a scale-down
    /// event.
    new_game_session_protection_policy: ?ProtectionPolicy = null,

    /// Policy settings that limit the number of game sessions an individual player
    /// can create
    /// over a span of time.
    resource_creation_limit_policy: ?ResourceCreationLimitPolicy = null,

    pub const json_field_names = .{
        .anywhere_configuration = "AnywhereConfiguration",
        .description = "Description",
        .fleet_id = "FleetId",
        .metric_groups = "MetricGroups",
        .name = "Name",
        .new_game_session_protection_policy = "NewGameSessionProtectionPolicy",
        .resource_creation_limit_policy = "ResourceCreationLimitPolicy",
    };
};

pub const UpdateFleetAttributesOutput = struct {
    /// The Amazon Resource Name
    /// ([ARN](https://docs.aws.amazon.com/AmazonS3/latest/dev/s3-arn-format.html))
    /// that is assigned to a Amazon GameLift Servers fleet resource and uniquely
    /// identifies it. ARNs are unique across all Regions. Format is
    /// `arn:aws:gamelift:::fleet/fleet-a1234567-b8c9-0d1e-2fa3-b45c6d7e8912`.
    fleet_arn: ?[]const u8 = null,

    /// A unique identifier for the fleet that was updated.
    fleet_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .fleet_arn = "FleetArn",
        .fleet_id = "FleetId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateFleetAttributesInput, options: CallOptions) !UpdateFleetAttributesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateFleetAttributesInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "GameLift.UpdateFleetAttributes");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateFleetAttributesOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateFleetAttributesOutput, body, allocator);
}
