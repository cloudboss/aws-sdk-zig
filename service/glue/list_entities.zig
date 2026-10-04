const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Entity = @import("entity.zig").Entity;

pub const ListEntitiesInput = struct {
    /// The catalog ID of the catalog that contains the connection. This can be
    /// null, By default, the Amazon Web Services Account ID is the catalog ID.
    catalog_id: ?[]const u8 = null,

    /// A name for the connection that has required credentials to query any
    /// connection type.
    connection_name: ?[]const u8 = null,

    /// The API version of the SaaS connector.
    data_store_api_version: ?[]const u8 = null,

    /// A continuation token, included if this is a continuation call.
    next_token: ?[]const u8 = null,

    /// Name of the parent entity for which you want to list the children. This
    /// parameter takes a fully-qualified path of the entity in order to list the
    /// child entities.
    parent_entity_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .catalog_id = "CatalogId",
        .connection_name = "ConnectionName",
        .data_store_api_version = "DataStoreApiVersion",
        .next_token = "NextToken",
        .parent_entity_name = "ParentEntityName",
    };
};

pub const ListEntitiesOutput = struct {
    /// A list of `Entity` objects.
    entities: ?[]const Entity = null,

    /// A continuation token, present if the current segment is not the last.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .entities = "Entities",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListEntitiesInput, options: CallOptions) !ListEntitiesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "glue", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListEntitiesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("glue", "Glue", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSGlue.ListEntities");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListEntitiesOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListEntitiesOutput, body, allocator);
}
