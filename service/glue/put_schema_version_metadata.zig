const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const MetadataKeyValuePair = @import("metadata_key_value_pair.zig").MetadataKeyValuePair;
const SchemaId = @import("schema_id.zig").SchemaId;
const SchemaVersionNumber = @import("schema_version_number.zig").SchemaVersionNumber;

pub const PutSchemaVersionMetadataInput = struct {
    /// The metadata key's corresponding value.
    metadata_key_value: MetadataKeyValuePair,

    /// The unique ID for the schema.
    schema_id: ?SchemaId = null,

    /// The unique version ID of the schema version.
    schema_version_id: ?[]const u8 = null,

    /// The version number of the schema.
    schema_version_number: ?SchemaVersionNumber = null,

    pub const json_field_names = .{
        .metadata_key_value = "MetadataKeyValue",
        .schema_id = "SchemaId",
        .schema_version_id = "SchemaVersionId",
        .schema_version_number = "SchemaVersionNumber",
    };
};

pub const PutSchemaVersionMetadataOutput = struct {
    /// The latest version of the schema.
    latest_version: ?bool = null,

    /// The metadata key.
    metadata_key: ?[]const u8 = null,

    /// The value of the metadata key.
    metadata_value: ?[]const u8 = null,

    /// The name for the registry.
    registry_name: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) for the schema.
    schema_arn: ?[]const u8 = null,

    /// The name for the schema.
    schema_name: ?[]const u8 = null,

    /// The unique version ID of the schema version.
    schema_version_id: ?[]const u8 = null,

    /// The version number of the schema.
    version_number: ?i64 = null,

    pub const json_field_names = .{
        .latest_version = "LatestVersion",
        .metadata_key = "MetadataKey",
        .metadata_value = "MetadataValue",
        .registry_name = "RegistryName",
        .schema_arn = "SchemaArn",
        .schema_name = "SchemaName",
        .schema_version_id = "SchemaVersionId",
        .version_number = "VersionNumber",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutSchemaVersionMetadataInput, options: CallOptions) !PutSchemaVersionMetadataOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: PutSchemaVersionMetadataInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSGlue.PutSchemaVersionMetadata");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutSchemaVersionMetadataOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(PutSchemaVersionMetadataOutput, body, allocator);
}
