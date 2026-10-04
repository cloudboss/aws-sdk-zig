const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const BatchGetSchemaError = @import("batch_get_schema_error.zig").BatchGetSchemaError;
const Schema = @import("schema.zig").Schema;

pub const BatchGetSchemaInput = struct {
    /// A unique identifier for the collaboration that the schemas belong to.
    /// Currently accepts collaboration ID.
    collaboration_identifier: []const u8,

    /// The names for the schema objects to retrieve.
    names: []const []const u8,

    pub const json_field_names = .{
        .collaboration_identifier = "collaborationIdentifier",
        .names = "names",
    };
};

pub const BatchGetSchemaOutput = struct {
    /// Error reasons for schemas that could not be retrieved. One error is returned
    /// for every schema that could not be retrieved.
    errors: ?[]const BatchGetSchemaError = null,

    /// The retrieved list of schemas.
    schemas: ?[]const Schema = null,

    pub const json_field_names = .{
        .errors = "errors",
        .schemas = "schemas",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: BatchGetSchemaInput, options: CallOptions) !BatchGetSchemaOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "cleanrooms", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: BatchGetSchemaInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cleanrooms", "CleanRooms", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/collaborations/");
    try path_buf.appendSlice(allocator, input.collaboration_identifier);
    try path_buf.appendSlice(allocator, "/batch-schema");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"names\":");
    try aws.json.writeValue(@TypeOf(input.names), input.names, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !BatchGetSchemaOutput {
    const result: BatchGetSchemaOutput = try aws.json.parseJsonObject(
        BatchGetSchemaOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
