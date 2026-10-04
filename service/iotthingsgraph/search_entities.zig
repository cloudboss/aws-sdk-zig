const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const EntityType = @import("entity_type.zig").EntityType;
const EntityFilter = @import("entity_filter.zig").EntityFilter;
const EntityDescription = @import("entity_description.zig").EntityDescription;

pub const SearchEntitiesInput = struct {
    /// The entity types for which to search.
    entity_types: []const EntityType,

    /// Optional filter to apply to the search. Valid filters are `NAME`
    /// `NAMESPACE`, `SEMANTIC_TYPE_PATH` and `REFERENCED_ENTITY_ID`.
    /// `REFERENCED_ENTITY_ID` filters on entities that are used by the entity in
    /// the result set. For example,
    /// you can filter on the ID of a property that is used in a state.
    ///
    /// Multiple filters function as OR criteria in the query. Multiple values
    /// passed inside the filter function as AND criteria.
    filters: ?[]const EntityFilter = null,

    /// The maximum number of results to return in the response.
    max_results: ?i32 = null,

    /// The version of the user's namespace. Defaults to the latest version of the
    /// user's namespace.
    namespace_version: ?i64 = null,

    /// The string that specifies the next page of results. Use this when you're
    /// paginating results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .entity_types = "entityTypes",
        .filters = "filters",
        .max_results = "maxResults",
        .namespace_version = "namespaceVersion",
        .next_token = "nextToken",
    };
};

pub const SearchEntitiesOutput = struct {
    /// An array of descriptions for each entity returned in the search result.
    descriptions: ?[]const EntityDescription = null,

    /// The string to specify as `nextToken` when you request the next page of
    /// results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .descriptions = "descriptions",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: SearchEntitiesInput, options: CallOptions) !SearchEntitiesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "iotthingsgraph", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: SearchEntitiesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iotthingsgraph", "IoTThingsGraph", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "IotThingsGraphFrontEndService.SearchEntities");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !SearchEntitiesOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(SearchEntitiesOutput, body, allocator);
}
