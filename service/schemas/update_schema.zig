const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Type = @import("type.zig").Type;

pub const UpdateSchemaInput = struct {
    /// The ID of the client token.
    client_token_id: ?[]const u8 = null,

    /// The source of the schema definition.
    content: ?[]const u8 = null,

    /// The description of the schema.
    description: ?[]const u8 = null,

    /// The name of the registry.
    registry_name: []const u8,

    /// The name of the schema.
    schema_name: []const u8,

    /// The schema type for the events schema.
    @"type": ?Type = null,

    pub const json_field_names = .{
        .client_token_id = "ClientTokenId",
        .content = "Content",
        .description = "Description",
        .registry_name = "RegistryName",
        .schema_name = "SchemaName",
        .@"type" = "Type",
    };
};

pub const UpdateSchemaOutput = struct {
    /// The description of the schema.
    description: ?[]const u8 = null,

    /// The date and time that schema was modified.
    last_modified: ?i64 = null,

    /// The ARN of the schema.
    schema_arn: ?[]const u8 = null,

    /// The name of the schema.
    schema_name: ?[]const u8 = null,

    /// The version number of the schema
    schema_version: ?[]const u8 = null,

    tags: ?[]const aws.map.StringMapEntry = null,

    /// The type of the schema.
    @"type": ?[]const u8 = null,

    /// The date the schema version was created.
    version_created_date: ?i64 = null,

    pub const json_field_names = .{
        .description = "Description",
        .last_modified = "LastModified",
        .schema_arn = "SchemaArn",
        .schema_name = "SchemaName",
        .schema_version = "SchemaVersion",
        .tags = "Tags",
        .@"type" = "Type",
        .version_created_date = "VersionCreatedDate",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateSchemaInput, options: CallOptions) !UpdateSchemaOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateSchemaInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("schemas", "schemas", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v1/registries/name/");
    try path_buf.appendSlice(allocator, input.registry_name);
    try path_buf.appendSlice(allocator, "/schemas/name/");
    try path_buf.appendSlice(allocator, input.schema_name);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.client_token_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ClientTokenId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.content) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Content\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.@"type") |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Type\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateSchemaOutput {
    const result: UpdateSchemaOutput = try aws.json.parseJsonObject(
        UpdateSchemaOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
