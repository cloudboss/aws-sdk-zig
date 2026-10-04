const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const ExportSchemaInput = struct {
    /// The name of the registry.
    registry_name: []const u8,

    /// The name of the schema.
    schema_name: []const u8,

    /// Specifying this limits the results to only this schema version.
    schema_version: ?[]const u8 = null,

    @"type": []const u8,

    pub const json_field_names = .{
        .registry_name = "RegistryName",
        .schema_name = "SchemaName",
        .schema_version = "SchemaVersion",
        .@"type" = "Type",
    };
};

pub const ExportSchemaOutput = struct {
    content: ?[]const u8 = null,

    schema_arn: ?[]const u8 = null,

    schema_name: ?[]const u8 = null,

    schema_version: ?[]const u8 = null,

    @"type": ?[]const u8 = null,

    pub const json_field_names = .{
        .content = "Content",
        .schema_arn = "SchemaArn",
        .schema_name = "SchemaName",
        .schema_version = "SchemaVersion",
        .@"type" = "Type",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ExportSchemaInput, options: CallOptions) !ExportSchemaOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "schemas", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ExportSchemaInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("schemas", "schemas", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v1/registries/name/");
    try path_buf.appendSlice(allocator, input.registry_name);
    try path_buf.appendSlice(allocator, "/schemas/name/");
    try path_buf.appendSlice(allocator, input.schema_name);
    try path_buf.appendSlice(allocator, "/export");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.schema_version) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "schemaVersion=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "type=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.@"type");
    query_has_prev = true;
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ExportSchemaOutput {
    var result: ExportSchemaOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ExportSchemaOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
