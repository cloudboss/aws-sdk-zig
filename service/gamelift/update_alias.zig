const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RoutingStrategy = @import("routing_strategy.zig").RoutingStrategy;
const Alias = @import("alias.zig").Alias;

pub const UpdateAliasInput = struct {
    /// A unique identifier for the alias that you want to update. You can use
    /// either the
    /// alias ID or ARN value.
    alias_id: []const u8,

    /// A human-readable description of the alias.
    description: ?[]const u8 = null,

    /// A descriptive label that is associated with an alias. Alias names do not
    /// need to be unique.
    name: ?[]const u8 = null,

    /// The routing configuration, including routing type and fleet target, for the
    /// alias.
    routing_strategy: ?RoutingStrategy = null,

    pub const json_field_names = .{
        .alias_id = "AliasId",
        .description = "Description",
        .name = "Name",
        .routing_strategy = "RoutingStrategy",
    };
};

pub const UpdateAliasOutput = struct {
    /// The updated alias resource.
    alias: ?Alias = null,

    pub const json_field_names = .{
        .alias = "Alias",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateAliasInput, options: CallOptions) !UpdateAliasOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateAliasInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "GameLift.UpdateAlias");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateAliasOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateAliasOutput, body, allocator);
}
