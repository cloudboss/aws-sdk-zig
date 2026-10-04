const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SchemaInputAttribute = @import("schema_input_attribute.zig").SchemaInputAttribute;

pub const GetSchemaMappingInput = struct {
    /// The name of the schema to be retrieved.
    schema_name: []const u8,

    pub const json_field_names = .{
        .schema_name = "schemaName",
    };
};

pub const GetSchemaMappingOutput = struct {
    /// The timestamp of when the `SchemaMapping` was created.
    created_at: i64,

    /// A description of the schema.
    description: ?[]const u8 = null,

    /// Specifies whether the schema mapping has been applied to a workflow.
    has_workflows: bool,

    /// A list of `MappedInputFields`. Each `MappedInputField` corresponds to a
    /// column the source data table, and contains column name plus additional
    /// information Entity Resolution uses for matching.
    mapped_input_fields: ?[]const SchemaInputAttribute = null,

    /// The ARN (Amazon Resource Name) that Entity Resolution generated for the
    /// SchemaMapping.
    schema_arn: []const u8,

    /// The name of the schema.
    schema_name: []const u8,

    /// The tags used to organize, track, or control access for this resource.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The timestamp of when the `SchemaMapping` was last updated.
    updated_at: i64,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .description = "description",
        .has_workflows = "hasWorkflows",
        .mapped_input_fields = "mappedInputFields",
        .schema_arn = "schemaArn",
        .schema_name = "schemaName",
        .tags = "tags",
        .updated_at = "updatedAt",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetSchemaMappingInput, options: CallOptions) !GetSchemaMappingOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "entityresolution", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetSchemaMappingInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("entityresolution", "EntityResolution", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/schemas/");
    try path_buf.appendSlice(allocator, input.schema_name);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetSchemaMappingOutput {
    var result: GetSchemaMappingOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetSchemaMappingOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
