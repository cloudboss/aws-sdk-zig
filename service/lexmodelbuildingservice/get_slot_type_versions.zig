const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SlotTypeMetadata = @import("slot_type_metadata.zig").SlotTypeMetadata;

pub const GetSlotTypeVersionsInput = struct {
    /// The maximum number of slot type versions to return in the response.
    /// The default is 10.
    max_results: ?i32 = null,

    /// The name of the slot type for which versions should be
    /// returned.
    name: []const u8,

    /// A pagination token for fetching the next page of slot type
    /// versions. If the response to this call is truncated, Amazon Lex returns a
    /// pagination token in the response. To fetch the next page of versions,
    /// specify the pagination token in the next request.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .max_results = "maxResults",
        .name = "name",
        .next_token = "nextToken",
    };
};

pub const GetSlotTypeVersionsOutput = struct {
    /// A pagination token for fetching the next page of slot type
    /// versions. If the response to this call is truncated, Amazon Lex returns a
    /// pagination token in the response. To fetch the next page of versions,
    /// specify the pagination token in the next request.
    next_token: ?[]const u8 = null,

    /// An array of `SlotTypeMetadata` objects, one for each
    /// numbered version of the slot type plus one for the `$LATEST`
    /// version.
    slot_types: ?[]const SlotTypeMetadata = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .slot_types = "slotTypes",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetSlotTypeVersionsInput, options: CallOptions) !GetSlotTypeVersionsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "lex", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetSlotTypeVersionsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("models.lex", "Lex Model Building Service", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/slottypes/");
    try path_buf.appendSlice(allocator, input.name);
    try path_buf.appendSlice(allocator, "/versions");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.max_results) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "maxResults=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (input.next_token) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "nextToken=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetSlotTypeVersionsOutput {
    var result: GetSlotTypeVersionsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetSlotTypeVersionsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
