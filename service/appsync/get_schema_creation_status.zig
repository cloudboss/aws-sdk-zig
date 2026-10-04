const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SchemaStatus = @import("schema_status.zig").SchemaStatus;

pub const GetSchemaCreationStatusInput = struct {
    /// The API ID.
    api_id: []const u8,

    pub const json_field_names = .{
        .api_id = "apiId",
    };
};

pub const GetSchemaCreationStatusOutput = struct {
    /// Detailed information about the status of the schema creation operation.
    details: ?[]const u8 = null,

    /// The current state of the schema (PROCESSING, FAILED, SUCCESS, or
    /// NOT_APPLICABLE). When
    /// the schema is in the ACTIVE state, you can add data.
    status: ?SchemaStatus = null,

    pub const json_field_names = .{
        .details = "details",
        .status = "status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetSchemaCreationStatusInput, options: CallOptions) !GetSchemaCreationStatusOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "appsync", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetSchemaCreationStatusInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("appsync", "AppSync", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v1/apis/");
    try path_buf.appendSlice(allocator, input.api_id);
    try path_buf.appendSlice(allocator, "/schemacreation");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetSchemaCreationStatusOutput {
    var result: GetSchemaCreationStatusOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetSchemaCreationStatusOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
