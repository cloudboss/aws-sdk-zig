const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SchemaVersionNumber = @import("schema_version_number.zig").SchemaVersionNumber;
const SchemaDiffType = @import("schema_diff_type.zig").SchemaDiffType;
const SchemaId = @import("schema_id.zig").SchemaId;

pub const GetSchemaVersionsDiffInput = struct {
    /// The first of the two schema versions to be compared.
    first_schema_version_number: SchemaVersionNumber,

    /// Refers to `SYNTAX_DIFF`, which is the currently supported diff type.
    schema_diff_type: SchemaDiffType,

    /// This is a wrapper structure to contain schema identity fields. The structure
    /// contains:
    ///
    /// * SchemaId$SchemaArn: The Amazon Resource Name (ARN) of the schema. One of
    ///   `SchemaArn` or `SchemaName` has to be provided.
    ///
    /// * SchemaId$SchemaName: The name of the schema. One of `SchemaArn` or
    ///   `SchemaName` has to be provided.
    schema_id: SchemaId,

    /// The second of the two schema versions to be compared.
    second_schema_version_number: SchemaVersionNumber,

    pub const json_field_names = .{
        .first_schema_version_number = "FirstSchemaVersionNumber",
        .schema_diff_type = "SchemaDiffType",
        .schema_id = "SchemaId",
        .second_schema_version_number = "SecondSchemaVersionNumber",
    };
};

pub const GetSchemaVersionsDiffOutput = struct {
    /// The difference between schemas as a string in JsonPatch format.
    diff: ?[]const u8 = null,

    pub const json_field_names = .{
        .diff = "Diff",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetSchemaVersionsDiffInput, options: CallOptions) !GetSchemaVersionsDiffOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetSchemaVersionsDiffInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSGlue.GetSchemaVersionsDiff");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetSchemaVersionsDiffOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetSchemaVersionsDiffOutput, body, allocator);
}
