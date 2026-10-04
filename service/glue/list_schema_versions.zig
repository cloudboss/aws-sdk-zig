const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SchemaId = @import("schema_id.zig").SchemaId;
const SchemaVersionListItem = @import("schema_version_list_item.zig").SchemaVersionListItem;

pub const ListSchemaVersionsInput = struct {
    /// Maximum number of results required per page. If the value is not supplied,
    /// this will be defaulted to 25 per page.
    max_results: ?i32 = null,

    /// A continuation token, if this is a continuation call.
    next_token: ?[]const u8 = null,

    /// This is a wrapper structure to contain schema identity fields. The structure
    /// contains:
    ///
    /// * SchemaId$SchemaArn: The Amazon Resource Name (ARN) of the schema. Either
    ///   `SchemaArn` or `SchemaName` and `RegistryName` has to be provided.
    ///
    /// * SchemaId$SchemaName: The name of the schema. Either `SchemaArn` or
    ///   `SchemaName` and `RegistryName` has to be provided.
    schema_id: SchemaId,

    pub const json_field_names = .{
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .schema_id = "SchemaId",
    };
};

pub const ListSchemaVersionsOutput = struct {
    /// A continuation token for paginating the returned list of tokens, returned if
    /// the current segment of the list is not the last.
    next_token: ?[]const u8 = null,

    /// An array of `SchemaVersionList` objects containing details of each schema
    /// version.
    schemas: ?[]const SchemaVersionListItem = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .schemas = "Schemas",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListSchemaVersionsInput, options: CallOptions) !ListSchemaVersionsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListSchemaVersionsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSGlue.ListSchemaVersions");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListSchemaVersionsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListSchemaVersionsOutput, body, allocator);
}
