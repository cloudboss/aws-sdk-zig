const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const MetadataKeyValuePair = @import("metadata_key_value_pair.zig").MetadataKeyValuePair;
const SchemaId = @import("schema_id.zig").SchemaId;
const SchemaVersionNumber = @import("schema_version_number.zig").SchemaVersionNumber;
const MetadataInfo = @import("metadata_info.zig").MetadataInfo;

pub const QuerySchemaVersionMetadataInput = struct {
    /// Maximum number of results required per page. If the value is not supplied,
    /// this will be defaulted to 25 per page.
    max_results: ?i32 = null,

    /// Search key-value pairs for metadata, if they are not provided all the
    /// metadata information will be fetched.
    metadata_list: ?[]const MetadataKeyValuePair = null,

    /// A continuation token, if this is a continuation call.
    next_token: ?[]const u8 = null,

    /// A wrapper structure that may contain the schema name and Amazon Resource
    /// Name (ARN).
    schema_id: ?SchemaId = null,

    /// The unique version ID of the schema version.
    schema_version_id: ?[]const u8 = null,

    /// The version number of the schema.
    schema_version_number: ?SchemaVersionNumber = null,

    pub const json_field_names = .{
        .max_results = "MaxResults",
        .metadata_list = "MetadataList",
        .next_token = "NextToken",
        .schema_id = "SchemaId",
        .schema_version_id = "SchemaVersionId",
        .schema_version_number = "SchemaVersionNumber",
    };
};

pub const QuerySchemaVersionMetadataOutput = struct {
    /// A map of a metadata key and associated values.
    metadata_info_map: ?[]const aws.map.MapEntry(MetadataInfo) = null,

    /// A continuation token for paginating the returned list of tokens, returned if
    /// the current segment of the list is not the last.
    next_token: ?[]const u8 = null,

    /// The unique version ID of the schema version.
    schema_version_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .metadata_info_map = "MetadataInfoMap",
        .next_token = "NextToken",
        .schema_version_id = "SchemaVersionId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: QuerySchemaVersionMetadataInput, options: CallOptions) !QuerySchemaVersionMetadataOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: QuerySchemaVersionMetadataInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSGlue.QuerySchemaVersionMetadata");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !QuerySchemaVersionMetadataOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(QuerySchemaVersionMetadataOutput, body, allocator);
}
