const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Retriever = @import("retriever.zig").Retriever;

pub const ListRetrieversInput = struct {
    /// The identifier of the Amazon Q Business application using the retriever.
    application_id: []const u8,

    /// The maximum number of retrievers returned.
    max_results: ?i32 = null,

    /// If the number of retrievers returned exceeds `maxResults`, Amazon Q Business
    /// returns a next token as a pagination token to retrieve the next set of
    /// retrievers.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .application_id = "applicationId",
        .max_results = "maxResults",
        .next_token = "nextToken",
    };
};

pub const ListRetrieversOutput = struct {
    /// If the response is truncated, Amazon Q Business returns this token, which
    /// you can use in a later request to list the next set of retrievers.
    next_token: ?[]const u8 = null,

    /// An array of summary information for one or more retrievers.
    retrievers: ?[]const Retriever = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .retrievers = "retrievers",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListRetrieversInput, options: CallOptions) !ListRetrieversOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "qbusiness", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListRetrieversInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("qbusiness", "QBusiness", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/applications/");
    try path_buf.appendSlice(allocator, input.application_id);
    try path_buf.appendSlice(allocator, "/retrievers");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListRetrieversOutput {
    var result: ListRetrieversOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListRetrieversOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
