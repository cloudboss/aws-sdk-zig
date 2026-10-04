const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Compatibility = @import("compatibility.zig").Compatibility;
const SchemaId = @import("schema_id.zig").SchemaId;
const SchemaVersionNumber = @import("schema_version_number.zig").SchemaVersionNumber;

pub const UpdateSchemaInput = struct {
    /// The new compatibility setting for the schema.
    compatibility: ?Compatibility = null,

    /// The new description for the schema.
    description: ?[]const u8 = null,

    /// This is a wrapper structure to contain schema identity fields. The structure
    /// contains:
    ///
    /// * SchemaId$SchemaArn: The Amazon Resource Name (ARN) of the schema. One of
    ///   `SchemaArn` or `SchemaName` has to be provided.
    ///
    /// * SchemaId$SchemaName: The name of the schema. One of `SchemaArn` or
    ///   `SchemaName` has to be provided.
    schema_id: SchemaId,

    /// Version number required for check pointing. One of `VersionNumber` or
    /// `Compatibility` has to be provided.
    schema_version_number: ?SchemaVersionNumber = null,

    pub const json_field_names = .{
        .compatibility = "Compatibility",
        .description = "Description",
        .schema_id = "SchemaId",
        .schema_version_number = "SchemaVersionNumber",
    };
};

pub const UpdateSchemaOutput = struct {
    /// The name of the registry that contains the schema.
    registry_name: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the schema.
    schema_arn: ?[]const u8 = null,

    /// The name of the schema.
    schema_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .registry_name = "RegistryName",
        .schema_arn = "SchemaArn",
        .schema_name = "SchemaName",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateSchemaInput, options: CallOptions) !UpdateSchemaOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateSchemaInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSGlue.UpdateSchema");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateSchemaOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateSchemaOutput, body, allocator);
}
