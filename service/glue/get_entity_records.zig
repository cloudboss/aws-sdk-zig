const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const GetEntityRecordsInput = struct {
    /// The catalog ID of the catalog that contains the connection. This can be
    /// null, By default, the Amazon Web Services Account ID is the catalog ID.
    catalog_id: ?[]const u8 = null,

    /// The name of the connection that contains the connection type credentials.
    connection_name: ?[]const u8 = null,

    /// Connector options that are required to query the data.
    connection_options: ?[]const aws.map.StringMapEntry = null,

    /// The API version of the SaaS connector.
    data_store_api_version: ?[]const u8 = null,

    /// Name of the entity that we want to query the preview data from the given
    /// connection type.
    entity_name: []const u8,

    /// A filter predicate that you can apply in the query request.
    filter_predicate: ?[]const u8 = null,

    /// Limits the number of records fetched with the request.
    limit: i64,

    /// A continuation token, included if this is a continuation call.
    next_token: ?[]const u8 = null,

    /// A parameter that orders the response preview data.
    order_by: ?[]const u8 = null,

    /// List of fields that we want to fetch as part of preview data.
    selected_fields: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .catalog_id = "CatalogId",
        .connection_name = "ConnectionName",
        .connection_options = "ConnectionOptions",
        .data_store_api_version = "DataStoreApiVersion",
        .entity_name = "EntityName",
        .filter_predicate = "FilterPredicate",
        .limit = "Limit",
        .next_token = "NextToken",
        .order_by = "OrderBy",
        .selected_fields = "SelectedFields",
    };
};

pub const GetEntityRecordsOutput = struct {
    /// A continuation token, present if the current segment is not the last.
    next_token: ?[]const u8 = null,

    /// A list of the requested objects.
    records: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .records = "Records",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetEntityRecordsInput, options: CallOptions) !GetEntityRecordsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetEntityRecordsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSGlue.GetEntityRecords");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetEntityRecordsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetEntityRecordsOutput, body, allocator);
}
