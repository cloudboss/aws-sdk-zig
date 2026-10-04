const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Field = @import("field.zig").Field;

pub const DescribeEntityInput = struct {
    /// The catalog ID of the catalog that contains the connection. This can be
    /// null, By default, the Amazon Web Services Account ID is the catalog ID.
    catalog_id: ?[]const u8 = null,

    /// The name of the connection that contains the connection type credentials.
    connection_name: []const u8,

    /// The version of the API used for the data store.
    data_store_api_version: ?[]const u8 = null,

    /// The name of the entity that you want to describe from the connection type.
    entity_name: []const u8,

    /// A continuation token, included if this is a continuation call.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .catalog_id = "CatalogId",
        .connection_name = "ConnectionName",
        .data_store_api_version = "DataStoreApiVersion",
        .entity_name = "EntityName",
        .next_token = "NextToken",
    };
};

pub const DescribeEntityOutput = struct {
    /// Describes the fields for that connector entity. This is the list of `Field`
    /// objects. `Field` is very similar to column in a database. The `Field` object
    /// has information about different properties associated with fields in the
    /// connector.
    fields: ?[]const Field = null,

    /// A continuation token, present if the current segment is not the last.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .fields = "Fields",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeEntityInput, options: CallOptions) !DescribeEntityOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeEntityInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSGlue.DescribeEntity");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeEntityOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeEntityOutput, body, allocator);
}
