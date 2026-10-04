const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const FlowAliasConcurrencyConfiguration = @import("flow_alias_concurrency_configuration.zig").FlowAliasConcurrencyConfiguration;
const FlowAliasRoutingConfigurationListItem = @import("flow_alias_routing_configuration_list_item.zig").FlowAliasRoutingConfigurationListItem;

pub const CreateFlowAliasInput = struct {
    /// A unique, case-sensitive identifier to ensure that the API request completes
    /// no more than one time. If this token matches a previous request, Amazon
    /// Bedrock ignores the request, but does not return an error. For more
    /// information, see [Ensuring
    /// idempotency](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/Run_Instance_Idempotency.html).
    client_token: ?[]const u8 = null,

    /// The configuration that specifies how nodes in the flow are executed in
    /// parallel.
    concurrency_configuration: ?FlowAliasConcurrencyConfiguration = null,

    /// A description for the alias.
    description: ?[]const u8 = null,

    /// The unique identifier of the flow for which to create an alias.
    flow_identifier: []const u8,

    /// A name for the alias.
    name: []const u8,

    /// Contains information about the version to which to map the alias.
    routing_configuration: []const FlowAliasRoutingConfigurationListItem,

    /// Any tags that you want to attach to the alias of the flow. For more
    /// information, see [Tagging resources in Amazon
    /// Bedrock](https://docs.aws.amazon.com/bedrock/latest/userguide/tagging.html).
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .concurrency_configuration = "concurrencyConfiguration",
        .description = "description",
        .flow_identifier = "flowIdentifier",
        .name = "name",
        .routing_configuration = "routingConfiguration",
        .tags = "tags",
    };
};

pub const CreateFlowAliasOutput = struct {
    /// The Amazon Resource Name (ARN) of the alias.
    arn: []const u8,

    /// The configuration that specifies how nodes in the flow are executed in
    /// parallel.
    concurrency_configuration: ?FlowAliasConcurrencyConfiguration = null,

    /// The time at which the alias was created.
    created_at: i64,

    /// The description of the alias.
    description: ?[]const u8 = null,

    /// The unique identifier of the flow that the alias belongs to.
    flow_id: []const u8,

    /// The unique identifier of the alias.
    id: []const u8,

    /// The name of the alias.
    name: []const u8,

    /// Contains information about the version that the alias is mapped to.
    routing_configuration: ?[]const FlowAliasRoutingConfigurationListItem = null,

    /// The time at which the alias of the flow was last updated.
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateFlowAliasInput, options: CallOptions) !CreateFlowAliasOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateFlowAliasInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock-agent", "Bedrock Agent", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/flows/");
    try path_buf.appendSlice(allocator, input.flow_identifier);
    try path_buf.appendSlice(allocator, "/aliases");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
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
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateFlowAliasOutput {
    const result: CreateFlowAliasOutput = try aws.json.parseJsonObject(
        CreateFlowAliasOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
