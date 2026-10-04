const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const IndexStatus = @import("index_status.zig").IndexStatus;

pub const CreateIndexInput = struct {
    domain_name: []const u8,

    /// The name of the index to create. Must be between 1 and 255 characters and
    /// follow OpenSearch naming conventions.
    index_name: []const u8,

    /// The JSON schema defining index mappings, settings, and semantic enrichment
    /// configuration. The schema specifies which text fields should be
    /// automatically enriched for semantic search capabilities and includes
    /// OpenSearch index configuration parameters.
    index_schema: []const u8,

    pub const json_field_names = .{
        .domain_name = "DomainName",
        .index_name = "IndexName",
        .index_schema = "IndexSchema",
    };
};

pub const CreateIndexOutput = struct {
    /// The status of the index creation operation.
    status: IndexStatus,

    pub const json_field_names = .{
        .status = "Status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateIndexInput, options: CallOptions) !CreateIndexOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "es", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateIndexInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("es", "OpenSearch", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/2021-01-01/opensearch/domain/");
    try path_buf.appendSlice(allocator, input.domain_name);
    try path_buf.appendSlice(allocator, "/index");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"IndexName\":");
    try aws.json.writeValue(@TypeOf(input.index_name), input.index_name, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"IndexSchema\":");
    try aws.json.writeValue(@TypeOf(input.index_schema), input.index_schema, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateIndexOutput {
    var result: CreateIndexOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateIndexOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
