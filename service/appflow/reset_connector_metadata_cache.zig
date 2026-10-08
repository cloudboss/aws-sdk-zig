const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ConnectorType = @import("connector_type.zig").ConnectorType;

pub const ResetConnectorMetadataCacheInput = struct {
    /// The API version that you specified in the connector profile that you’re
    /// resetting cached
    /// metadata for. You must use this parameter only if the connector supports
    /// multiple API versions
    /// or if the connector type is CustomConnector.
    ///
    /// To look up how many versions a connector supports, use the
    /// DescribeConnectors action. In
    /// the response, find the value that Amazon AppFlow returns for the
    /// connectorVersion
    /// parameter.
    ///
    /// To look up the connector type, use the DescribeConnectorProfiles action. In
    /// the response,
    /// find the value that Amazon AppFlow returns for the connectorType parameter.
    ///
    /// To look up the API version that you specified in a connector profile, use
    /// the
    /// DescribeConnectorProfiles action.
    api_version: ?[]const u8 = null,

    /// Use this parameter if you want to reset cached metadata about the details
    /// for an
    /// individual entity.
    ///
    /// If you don't include this parameter in your request, Amazon AppFlow only
    /// resets
    /// cached metadata about entity names, not entity details.
    connector_entity_name: ?[]const u8 = null,

    /// The name of the connector profile that you want to reset cached metadata
    /// for.
    ///
    /// You can omit this parameter if you're resetting the cache for any of the
    /// following
    /// connectors: Connect Customer, Amazon EventBridge, Amazon Lookout for
    /// Metrics, Amazon S3, or Upsolver. If you're resetting the cache for any other
    /// connector, you must include this
    /// parameter in your request.
    connector_profile_name: ?[]const u8 = null,

    /// The type of connector to reset cached metadata for.
    ///
    /// You must include this parameter in your request if you're resetting the
    /// cache for any of
    /// the following connectors: Connect Customer, Amazon EventBridge, Amazon
    /// Lookout for Metrics,
    /// Amazon S3, or Upsolver. If you're resetting the cache for any other
    /// connector, you
    /// can omit this parameter from your request.
    connector_type: ?ConnectorType = null,

    /// Use this parameter only if you’re resetting the cached metadata about a
    /// nested entity.
    /// Only some connectors support nested entities. A nested entity is one that
    /// has another entity
    /// as a parent. To use this parameter, specify the name of the parent entity.
    ///
    /// To look up the parent-child relationship of entities, you can send a
    /// ListConnectorEntities
    /// request that omits the entitiesPath parameter. Amazon AppFlow will return a
    /// list of
    /// top-level entities. For each one, it indicates whether the entity has nested
    /// entities. Then,
    /// in a subsequent ListConnectorEntities request, you can specify a parent
    /// entity name for the
    /// entitiesPath parameter. Amazon AppFlow will return a list of the child
    /// entities for that
    /// parent.
    entities_path: ?[]const u8 = null,

    pub const json_field_names = .{
        .api_version = "apiVersion",
        .connector_entity_name = "connectorEntityName",
        .connector_profile_name = "connectorProfileName",
        .connector_type = "connectorType",
        .entities_path = "entitiesPath",
    };
};

pub const ResetConnectorMetadataCacheOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ResetConnectorMetadataCacheInput, options: CallOptions) !ResetConnectorMetadataCacheOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ResetConnectorMetadataCacheInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("appflow", "Appflow", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/reset-connector-metadata-cache";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.api_version) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"apiVersion\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.connector_entity_name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"connectorEntityName\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ResetConnectorMetadataCacheOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: ResetConnectorMetadataCacheOutput = .{};

    return result;
}
