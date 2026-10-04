const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SchemaId = @import("schema_id.zig").SchemaId;
const SchemaVersionNumber = @import("schema_version_number.zig").SchemaVersionNumber;
const DataFormat = @import("data_format.zig").DataFormat;
const SchemaVersionStatus = @import("schema_version_status.zig").SchemaVersionStatus;

pub const GetSchemaVersionInput = struct {
    /// This is a wrapper structure to contain schema identity fields. The structure
    /// contains:
    ///
    /// * SchemaId$SchemaArn: The Amazon Resource Name (ARN) of the schema. Either
    ///   `SchemaArn` or `SchemaName` and `RegistryName` has to be provided.
    ///
    /// * SchemaId$SchemaName: The name of the schema. Either `SchemaArn` or
    ///   `SchemaName` and `RegistryName` has to be provided.
    schema_id: ?SchemaId = null,

    /// The `SchemaVersionId` of the schema version. This field is required for
    /// fetching by schema ID. Either this or the `SchemaId` wrapper has to be
    /// provided.
    schema_version_id: ?[]const u8 = null,

    /// The version number of the schema.
    schema_version_number: ?SchemaVersionNumber = null,

    pub const json_field_names = .{
        .schema_id = "SchemaId",
        .schema_version_id = "SchemaVersionId",
        .schema_version_number = "SchemaVersionNumber",
    };
};

pub const GetSchemaVersionOutput = struct {
    /// The date and time the schema version was created.
    created_time: ?[]const u8 = null,

    /// The data format of the schema definition. Currently `AVRO`, `JSON` and
    /// `PROTOBUF` are supported.
    data_format: ?DataFormat = null,

    /// The Amazon Resource Name (ARN) of the schema.
    schema_arn: ?[]const u8 = null,

    /// The schema definition for the schema ID.
    schema_definition: ?[]const u8 = null,

    /// The `SchemaVersionId` of the schema version.
    schema_version_id: ?[]const u8 = null,

    /// The status of the schema version.
    status: ?SchemaVersionStatus = null,

    /// The version number of the schema.
    version_number: ?i64 = null,

    pub const json_field_names = .{
        .created_time = "CreatedTime",
        .data_format = "DataFormat",
        .schema_arn = "SchemaArn",
        .schema_definition = "SchemaDefinition",
        .schema_version_id = "SchemaVersionId",
        .status = "Status",
        .version_number = "VersionNumber",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetSchemaVersionInput, options: CallOptions) !GetSchemaVersionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetSchemaVersionInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSGlue.GetSchemaVersion");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetSchemaVersionOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetSchemaVersionOutput, body, allocator);
}
