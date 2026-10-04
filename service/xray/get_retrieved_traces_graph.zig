const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RetrievalStatus = @import("retrieval_status.zig").RetrievalStatus;
const RetrievedService = @import("retrieved_service.zig").RetrievedService;

pub const GetRetrievedTracesGraphInput = struct {
    /// Specify the pagination token returned by a previous request to retrieve the
    /// next page of indexes.
    next_token: ?[]const u8 = null,

    /// Retrieval token.
    retrieval_token: []const u8,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .retrieval_token = "RetrievalToken",
    };
};

pub const GetRetrievedTracesGraphOutput = struct {
    /// Specify the pagination token returned by a previous request to retrieve the
    /// next page of indexes.
    next_token: ?[]const u8 = null,

    /// Status of the retrieval.
    retrieval_status: ?RetrievalStatus = null,

    /// Retrieved services.
    services: ?[]const RetrievedService = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .retrieval_status = "RetrievalStatus",
        .services = "Services",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetRetrievedTracesGraphInput, options: CallOptions) !GetRetrievedTracesGraphOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "xray", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetRetrievedTracesGraphInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("xray", "XRay", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/GetRetrievedTracesGraph";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.next_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"NextToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"RetrievalToken\":");
    try aws.json.writeValue(@TypeOf(input.retrieval_token), input.retrieval_token, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetRetrievedTracesGraphOutput {
    const result: GetRetrievedTracesGraphOutput = try aws.json.parseJsonObject(
        GetRetrievedTracesGraphOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
