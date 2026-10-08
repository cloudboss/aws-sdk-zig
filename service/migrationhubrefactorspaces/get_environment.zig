const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ErrorResponse = @import("error_response.zig").ErrorResponse;
const NetworkFabricType = @import("network_fabric_type.zig").NetworkFabricType;
const EnvironmentState = @import("environment_state.zig").EnvironmentState;

pub const GetEnvironmentInput = struct {
    /// The ID of the environment.
    environment_identifier: []const u8,

    pub const json_field_names = .{
        .environment_identifier = "EnvironmentIdentifier",
    };
};

pub const GetEnvironmentOutput = struct {
    /// The Amazon Resource Name (ARN) of the environment.
    arn: ?[]const u8 = null,

    /// A timestamp that indicates when the environment is created.
    created_time: ?i64 = null,

    /// The description of the environment.
    description: ?[]const u8 = null,

    /// The unique identifier of the environment.
    environment_id: ?[]const u8 = null,

    /// Any error associated with the environment resource.
    @"error": ?ErrorResponse = null,

    /// A timestamp that indicates when the environment was last updated.
    last_updated_time: ?i64 = null,

    /// The name of the environment.
    name: ?[]const u8 = null,

    /// The network fabric type of the environment.
    network_fabric_type: ?NetworkFabricType = null,

    /// The Amazon Web Services account ID of the environment owner.
    owner_account_id: ?[]const u8 = null,

    /// The current state of the environment.
    state: ?EnvironmentState = null,

    /// The tags to assign to the environment. A tag is a label that you assign to
    /// an Amazon Web Services resource. Each tag consists of a key-value pair.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The ID of the Transit Gateway set up by the environment, if applicable.
    transit_gateway_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .created_time = "CreatedTime",
        .description = "Description",
        .environment_id = "EnvironmentId",
        .@"error" = "Error",
        .last_updated_time = "LastUpdatedTime",
        .name = "Name",
        .network_fabric_type = "NetworkFabricType",
        .owner_account_id = "OwnerAccountId",
        .state = "State",
        .tags = "Tags",
        .transit_gateway_id = "TransitGatewayId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetEnvironmentInput, options: CallOptions) !GetEnvironmentOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "refactor-spaces", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetEnvironmentInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("refactor-spaces", "Migration Hub Refactor Spaces", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/environments/");
    try path_buf.appendSlice(allocator, input.environment_identifier);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetEnvironmentOutput {
    const result: GetEnvironmentOutput = try aws.json.parseJsonObject(
        GetEnvironmentOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
