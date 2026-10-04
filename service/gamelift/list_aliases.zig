const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RoutingStrategyType = @import("routing_strategy_type.zig").RoutingStrategyType;
const Alias = @import("alias.zig").Alias;

pub const ListAliasesInput = struct {
    /// The maximum number of results to return. Use this parameter with `NextToken`
    /// to get results as a set of sequential pages.
    limit: ?i32 = null,

    /// A descriptive label that is associated with an alias. Alias names do not
    /// need to be unique.
    name: ?[]const u8 = null,

    /// A token that indicates the start of the next sequential page of results. Use
    /// the token that is returned with a previous call to this operation. To start
    /// at the beginning of the result set, do not specify a value.
    next_token: ?[]const u8 = null,

    /// The routing type to filter results on. Use this parameter to retrieve only
    /// aliases
    /// with a certain routing type. To retrieve all aliases, leave this parameter
    /// empty.
    ///
    /// Possible routing types include the following:
    ///
    /// * **SIMPLE** -- The alias resolves to one specific
    /// fleet. Use this type when routing to active fleets.
    ///
    /// * **TERMINAL** -- The alias does not resolve to a
    /// fleet but instead can be used to display a message to the user. A terminal
    /// alias
    /// throws a TerminalRoutingStrategyException with the
    /// [RoutingStrategy](https://docs.aws.amazon.com/gamelift/latest/apireference/API_RoutingStrategy.html) message embedded.
    routing_strategy_type: ?RoutingStrategyType = null,

    pub const json_field_names = .{
        .limit = "Limit",
        .name = "Name",
        .next_token = "NextToken",
        .routing_strategy_type = "RoutingStrategyType",
    };
};

pub const ListAliasesOutput = struct {
    /// A collection of alias resources that match the request parameters.
    aliases: ?[]const Alias = null,

    /// A token that indicates where to resume retrieving results on the next call
    /// to this operation. If no token is returned, these results represent the end
    /// of the list.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .aliases = "Aliases",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListAliasesInput, options: CallOptions) !ListAliasesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListAliasesInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "GameLift.ListAliases");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListAliasesOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListAliasesOutput, body, allocator);
}
