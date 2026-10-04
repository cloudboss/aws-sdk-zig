const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ConnectorType = @import("connector_type.zig").ConnectorType;
const ConnectorEntity = @import("connector_entity.zig").ConnectorEntity;

pub const ListConnectorEntitiesInput = struct {
    /// The version of the API that's used by the connector.
    api_version: ?[]const u8 = null,

    /// The name of the connector profile. The name is unique for each
    /// `ConnectorProfile` in the Amazon Web Services account, and is used to query
    /// the
    /// downstream connector.
    connector_profile_name: ?[]const u8 = null,

    /// The type of connector, such as Salesforce, Amplitude, and so on.
    connector_type: ?ConnectorType = null,

    /// This optional parameter is specific to connector implementation. Some
    /// connectors support
    /// multiple levels or categories of entities. You can find out the list of
    /// roots for such
    /// providers by sending a request without the `entitiesPath` parameter. If the
    /// connector supports entities at different roots, this initial request returns
    /// the list of
    /// roots. Otherwise, this request returns all entities supported by the
    /// provider.
    entities_path: ?[]const u8 = null,

    /// The maximum number of items that the operation returns in the response.
    max_results: ?i32 = null,

    /// A token that was provided by your prior `ListConnectorEntities` operation if
    /// the response was too big for the page size. You specify this token to get
    /// the next page of
    /// results in paginated response.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .api_version = "apiVersion",
        .connector_profile_name = "connectorProfileName",
        .connector_type = "connectorType",
        .entities_path = "entitiesPath",
        .max_results = "maxResults",
        .next_token = "nextToken",
    };
};

pub const ListConnectorEntitiesOutput = struct {
    /// The response of `ListConnectorEntities` lists entities grouped by category.
    /// This map's key represents the group name, and its value contains the list of
    /// entities
    /// belonging to that group.
    connector_entity_map: ?[]const aws.map.MapEntry([]const ConnectorEntity) = null,

    /// A token that you specify in your next `ListConnectorEntities` operation to
    /// get
    /// the next page of results in paginated response. The `ListConnectorEntities`
    /// operation provides this token if the response is too big for the page size.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .connector_entity_map = "connectorEntityMap",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListConnectorEntitiesInput, options: CallOptions) !ListConnectorEntitiesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "appflow", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListConnectorEntitiesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("appflow", "Appflow", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/list-connector-entities";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.api_version) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"apiVersion\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.connector_profile_name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"connectorProfileName\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.connector_type) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"connectorType\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.entities_path) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"entitiesPath\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.max_results) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"maxResults\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.next_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"nextToken\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListConnectorEntitiesOutput {
    var result: ListConnectorEntitiesOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListConnectorEntitiesOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
