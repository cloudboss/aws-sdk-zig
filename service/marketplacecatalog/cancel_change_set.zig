const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const CancelChangeSetInput = struct {
    /// Required. The catalog related to the request. Fixed value:
    /// `AWSMarketplace`.
    catalog: []const u8,

    /// Required. The unique identifier of the `StartChangeSet` request that you
    /// want to cancel.
    change_set_id: []const u8,

    pub const json_field_names = .{
        .catalog = "Catalog",
        .change_set_id = "ChangeSetId",
    };
};

pub const CancelChangeSetOutput = struct {
    /// The ARN associated with the change set referenced in this request.
    change_set_arn: ?[]const u8 = null,

    /// The unique identifier for the change set referenced in this request.
    change_set_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .change_set_arn = "ChangeSetArn",
        .change_set_id = "ChangeSetId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CancelChangeSetInput, options: CallOptions) !CancelChangeSetOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CancelChangeSetInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("catalog.marketplace", "Marketplace Catalog", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/CancelChangeSet";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "catalog=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.catalog);
    query_has_prev = true;
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "changeSetId=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.change_set_id);
    query_has_prev = true;
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .PATCH;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CancelChangeSetOutput {
    const result: CancelChangeSetOutput = try aws.json.parseJsonObject(
        CancelChangeSetOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
