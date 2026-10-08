const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SchemaVersionFormat = @import("schema_version_format.zig").SchemaVersionFormat;
const SchemaVersionType = @import("schema_version_type.zig").SchemaVersionType;
const SchemaVersionVisibility = @import("schema_version_visibility.zig").SchemaVersionVisibility;

pub const GetSchemaVersionInput = struct {
    /// The format of the schema version.
    format: ?SchemaVersionFormat = null,

    /// Schema id with a version specified. If the version is missing, it defaults
    /// to latest version.
    schema_versioned_id: []const u8,

    /// The type of schema version.
    type: SchemaVersionType,

    pub const json_field_names = .{
        .format = "Format",
        .schema_versioned_id = "SchemaVersionedId",
        .type = "Type",
    };
};

pub const GetSchemaVersionOutput = struct {
    /// The description of the schema version.
    description: ?[]const u8 = null,

    /// The name of the schema version.
    namespace: ?[]const u8 = null,

    /// The schema of the schema version.
    schema: ?[]const u8 = null,

    /// The id of the schema version.
    schema_id: ?[]const u8 = null,

    /// The schema version. If this is left blank, it defaults to the latest
    /// version.
    semantic_version: ?[]const u8 = null,

    /// The type of schema version.
    type: ?SchemaVersionType = null,

    /// The visibility of the schema version.
    visibility: ?SchemaVersionVisibility = null,

    pub const json_field_names = .{
        .description = "Description",
        .namespace = "Namespace",
        .schema = "Schema",
        .schema_id = "SchemaId",
        .semantic_version = "SemanticVersion",
        .type = "Type",
        .visibility = "Visibility",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetSchemaVersionInput, options: CallOptions) !GetSchemaVersionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "iotmanagedintegrations", client.config.http_client.clock_skew_offset);

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
    const endpoint = try config.getEndpointForService("api.iotmanagedintegrations", "IoT Managed Integrations", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/schema-versions/");
    try path_buf.appendSlice(allocator, input.type.wireName());
    try path_buf.appendSlice(allocator, "/");
    try path_buf.appendSlice(allocator, input.schema_versioned_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.format) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "Format=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v.wireName());
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetSchemaVersionOutput {
    const result: GetSchemaVersionOutput = try aws.json.parseJsonObject(
        GetSchemaVersionOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
