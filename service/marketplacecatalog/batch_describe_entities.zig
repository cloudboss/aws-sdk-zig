const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const EntityRequest = @import("entity_request.zig").EntityRequest;
const EntityDetail = @import("entity_detail.zig").EntityDetail;
const BatchDescribeErrorDetail = @import("batch_describe_error_detail.zig").BatchDescribeErrorDetail;

pub const BatchDescribeEntitiesInput = struct {
    /// List of entity IDs and the catalogs the entities are present in.
    entity_request_list: []const EntityRequest,

    pub const json_field_names = .{
        .entity_request_list = "EntityRequestList",
    };
};

pub const BatchDescribeEntitiesOutput = struct {
    /// Details about each entity.
    entity_details: ?[]const aws.map.MapEntry(EntityDetail) = null,

    /// A map of errors returned, with `EntityId` as the key and
    /// `errorDetail` as the value.
    errors: ?[]const aws.map.MapEntry(BatchDescribeErrorDetail) = null,

    pub const json_field_names = .{
        .entity_details = "EntityDetails",
        .errors = "Errors",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: BatchDescribeEntitiesInput, options: CallOptions) !BatchDescribeEntitiesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "aws-marketplace", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: BatchDescribeEntitiesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("catalog.marketplace", "Marketplace Catalog", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/BatchDescribeEntities";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"EntityRequestList\":");
    try aws.json.writeValue(@TypeOf(input.entity_request_list), input.entity_request_list, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !BatchDescribeEntitiesOutput {
    const result: BatchDescribeEntitiesOutput = try aws.json.parseJsonObject(
        BatchDescribeEntitiesOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
