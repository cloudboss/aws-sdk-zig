const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SchemaId = @import("schema_id.zig").SchemaId;
const Compatibility = @import("compatibility.zig").Compatibility;
const DataFormat = @import("data_format.zig").DataFormat;
const SchemaStatus = @import("schema_status.zig").SchemaStatus;

pub const GetSchemaInput = struct {
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
        .schema_id = "SchemaId",
    };
};

pub const GetSchemaOutput = struct {
    /// The compatibility mode of the schema.
    compatibility: ?Compatibility = null,

    /// The date and time the schema was created.
    created_time: ?[]const u8 = null,

    /// The data format of the schema definition. Currently `AVRO`, `JSON` and
    /// `PROTOBUF` are supported.
    data_format: ?DataFormat = null,

    /// A description of schema if specified when created
    description: ?[]const u8 = null,

    /// The latest version of the schema associated with the returned schema
    /// definition.
    latest_schema_version: ?i64 = null,

    /// The next version of the schema associated with the returned schema
    /// definition.
    next_schema_version: ?i64 = null,

    /// The Amazon Resource Name (ARN) of the registry.
    registry_arn: ?[]const u8 = null,

    /// The name of the registry.
    registry_name: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the schema.
    schema_arn: ?[]const u8 = null,

    /// The version number of the checkpoint (the last time the compatibility mode
    /// was changed).
    schema_checkpoint: ?i64 = null,

    /// The name of the schema.
    schema_name: ?[]const u8 = null,

    /// The status of the schema.
    schema_status: ?SchemaStatus = null,

    /// The date and time the schema was updated.
    updated_time: ?[]const u8 = null,

    pub const json_field_names = .{
        .compatibility = "Compatibility",
        .created_time = "CreatedTime",
        .data_format = "DataFormat",
        .description = "Description",
        .latest_schema_version = "LatestSchemaVersion",
        .next_schema_version = "NextSchemaVersion",
        .registry_arn = "RegistryArn",
        .registry_name = "RegistryName",
        .schema_arn = "SchemaArn",
        .schema_checkpoint = "SchemaCheckpoint",
        .schema_name = "SchemaName",
        .schema_status = "SchemaStatus",
        .updated_time = "UpdatedTime",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetSchemaInput, options: CallOptions) !GetSchemaOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetSchemaInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSGlue.GetSchema");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetSchemaOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetSchemaOutput, body, allocator);
}
