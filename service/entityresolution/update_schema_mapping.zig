const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SchemaInputAttribute = @import("schema_input_attribute.zig").SchemaInputAttribute;

pub const UpdateSchemaMappingInput = struct {
    /// A description of the schema.
    description: ?[]const u8 = null,

    /// A list of `MappedInputFields`. Each `MappedInputField` corresponds to a
    /// column the source data table, and contains column name plus additional
    /// information that Entity Resolution uses for matching.
    mapped_input_fields: []const SchemaInputAttribute,

    /// The name of the schema. There can't be multiple `SchemaMappings` with the
    /// same name.
    schema_name: []const u8,

    pub const json_field_names = .{
        .description = "description",
        .mapped_input_fields = "mappedInputFields",
        .schema_name = "schemaName",
    };
};

pub const UpdateSchemaMappingOutput = struct {
    /// A description of the schema.
    description: ?[]const u8 = null,

    /// A list of `MappedInputFields`. Each `MappedInputField` corresponds to a
    /// column the source data table, and contains column name plus additional
    /// information that Entity Resolution uses for matching.
    mapped_input_fields: ?[]const SchemaInputAttribute = null,

    /// The ARN (Amazon Resource Name) that Entity Resolution generated for the
    /// `SchemaMapping`.
    schema_arn: []const u8,

    /// The name of the schema.
    schema_name: []const u8,

    pub const json_field_names = .{
        .description = "description",
        .mapped_input_fields = "mappedInputFields",
        .schema_arn = "schemaArn",
        .schema_name = "schemaName",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateSchemaMappingInput, options: CallOptions) !UpdateSchemaMappingOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateSchemaMappingInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("entityresolution", "EntityResolution", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/schemas/");
    try path_buf.appendSlice(allocator, input.schema_name);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"mappedInputFields\":");
    try aws.json.writeValue(@TypeOf(input.mapped_input_fields), input.mapped_input_fields, allocator, &body_buf);
    has_prev = true;

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateSchemaMappingOutput {
    const result: UpdateSchemaMappingOutput = try aws.json.parseJsonObject(
        UpdateSchemaMappingOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
