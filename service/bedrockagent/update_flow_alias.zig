const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const FlowAliasConcurrencyConfiguration = @import("flow_alias_concurrency_configuration.zig").FlowAliasConcurrencyConfiguration;
const FlowAliasRoutingConfigurationListItem = @import("flow_alias_routing_configuration_list_item.zig").FlowAliasRoutingConfigurationListItem;

pub const UpdateFlowAliasInput = struct {
    /// The unique identifier of the alias.
    alias_identifier: []const u8,

    /// The configuration that specifies how nodes in the flow are executed in
    /// parallel.
    concurrency_configuration: ?FlowAliasConcurrencyConfiguration = null,

    /// A description for the alias.
    description: ?[]const u8 = null,

    /// The unique identifier of the flow.
    flow_identifier: []const u8,

    /// The name of the alias.
    name: []const u8,

    /// Contains information about the version to which to map the alias.
    routing_configuration: []const FlowAliasRoutingConfigurationListItem,

    pub const json_field_names = .{
        .alias_identifier = "aliasIdentifier",
        .concurrency_configuration = "concurrencyConfiguration",
        .description = "description",
        .flow_identifier = "flowIdentifier",
        .name = "name",
        .routing_configuration = "routingConfiguration",
    };
};

pub const UpdateFlowAliasOutput = struct {
    /// The Amazon Resource Name (ARN) of the flow.
    arn: []const u8,

    /// The configuration that specifies how nodes in the flow are executed in
    /// parallel.
    concurrency_configuration: ?FlowAliasConcurrencyConfiguration = null,

    /// The time at which the flow was created.
    created_at: i64,

    /// The description of the flow.
    description: ?[]const u8 = null,

    /// The unique identifier of the flow.
    flow_id: []const u8,

    /// The unique identifier of the alias.
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateFlowAliasInput, options: CallOptions) !UpdateFlowAliasOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateFlowAliasInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock-agent", "Bedrock Agent", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/flows/");
    try path_buf.appendSlice(allocator, input.flow_identifier);
    try path_buf.appendSlice(allocator, "/aliases/");
    try path_buf.appendSlice(allocator, input.alias_identifier);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.concurrency_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"concurrencyConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"routingConfiguration\":");
    try aws.json.writeValue(@TypeOf(input.routing_configuration), input.routing_configuration, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateFlowAliasOutput {
    var result: UpdateFlowAliasOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateFlowAliasOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
