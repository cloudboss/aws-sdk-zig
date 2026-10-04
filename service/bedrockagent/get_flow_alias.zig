const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const FlowAliasConcurrencyConfiguration = @import("flow_alias_concurrency_configuration.zig").FlowAliasConcurrencyConfiguration;
const FlowAliasRoutingConfigurationListItem = @import("flow_alias_routing_configuration_list_item.zig").FlowAliasRoutingConfigurationListItem;

pub const GetFlowAliasInput = struct {
    /// The unique identifier of the alias for which to retrieve information.
    alias_identifier: []const u8,

    /// The unique identifier of the flow that the alias belongs to.
    flow_identifier: []const u8,

    pub const json_field_names = .{
        .alias_identifier = "aliasIdentifier",
        .flow_identifier = "flowIdentifier",
    };
};

pub const GetFlowAliasOutput = struct {
    /// The Amazon Resource Name (ARN) of the flow.
    arn: []const u8,

    /// The configuration that specifies how nodes in the flow are executed in
    /// parallel.
    concurrency_configuration: ?FlowAliasConcurrencyConfiguration = null,

    /// The time at which the flow was created.
    created_at: i64,

    /// The description of the flow.
    description: ?[]const u8 = null,

    /// The unique identifier of the flow that the alias belongs to.
    flow_id: []const u8,

    /// The unique identifier of the alias of the flow.
    id: []const u8,

    /// The name of the alias.
    name: []const u8,

    /// Contains information about the version that the alias is mapped to.
    routing_configuration: ?[]const FlowAliasRoutingConfigurationListItem = null,

    /// The time at which the alias was last updated.
    updated_at: i64,

    pub const json_field_names = .{
        .arn = "arn",
        .concurrency_configuration = "concurrencyConfiguration",
        .created_at = "createdAt",
        .description = "description",
        .flow_id = "flowId",
        .id = "id",
        .name = "name",
        .routing_configuration = "routingConfiguration",
        .updated_at = "updatedAt",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetFlowAliasInput, options: CallOptions) !GetFlowAliasOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "bedrock", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetFlowAliasInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock-agent", "Bedrock Agent", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/flows/");
    try path_buf.appendSlice(allocator, input.flow_identifier);
    try path_buf.appendSlice(allocator, "/aliases/");
    try path_buf.appendSlice(allocator, input.alias_identifier);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetFlowAliasOutput {
    const result: GetFlowAliasOutput = try aws.json.parseJsonObject(
        GetFlowAliasOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
