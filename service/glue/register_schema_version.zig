const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SchemaId = @import("schema_id.zig").SchemaId;
const SchemaVersionStatus = @import("schema_version_status.zig").SchemaVersionStatus;

pub const RegisterSchemaVersionInput = struct {
    /// The schema definition using the `DataFormat` setting for the `SchemaName`.
    schema_definition: []const u8,

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
        .schema_definition = "SchemaDefinition",
        .schema_id = "SchemaId",
    };
};

pub const RegisterSchemaVersionOutput = struct {
    /// The unique ID that represents the version of this schema.
    schema_version_id: ?[]const u8 = null,

    /// The status of the schema version.
    status: ?SchemaVersionStatus = null,

    /// The version of this schema (for sync flow only, in case this is the first
    /// version).
    version_number: ?i64 = null,

    pub const json_field_names = .{
        .schema_version_id = "SchemaVersionId",
        .status = "Status",
        .version_number = "VersionNumber",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: RegisterSchemaVersionInput, options: CallOptions) !RegisterSchemaVersionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: RegisterSchemaVersionInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSGlue.RegisterSchemaVersion");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !RegisterSchemaVersionOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(RegisterSchemaVersionOutput, body, allocator);
}
