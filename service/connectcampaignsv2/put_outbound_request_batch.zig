const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const OutboundRequest = @import("outbound_request.zig").OutboundRequest;
const FailedRequest = @import("failed_request.zig").FailedRequest;
const SuccessfulRequest = @import("successful_request.zig").SuccessfulRequest;

pub const PutOutboundRequestBatchInput = struct {
    id: []const u8,

    outbound_requests: []const OutboundRequest,

    pub const json_field_names = .{
        .id = "id",
        .outbound_requests = "outboundRequests",
    };
};

pub const PutOutboundRequestBatchOutput = struct {
    failed_requests: ?[]const FailedRequest = null,

    successful_requests: ?[]const SuccessfulRequest = null,

    pub const json_field_names = .{
        .failed_requests = "failedRequests",
        .successful_requests = "successfulRequests",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutOutboundRequestBatchInput, options: CallOptions) !PutOutboundRequestBatchOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "connect-campaigns", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: PutOutboundRequestBatchInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("connect-campaigns", "ConnectCampaignsV2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v2/campaigns/");
    try path_buf.appendSlice(allocator, input.id);
    try path_buf.appendSlice(allocator, "/outbound-requests");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"outboundRequests\":");
    try aws.json.writeValue(@TypeOf(input.outbound_requests), input.outbound_requests, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutOutboundRequestBatchOutput {
    const result: PutOutboundRequestBatchOutput = try aws.json.parseJsonObject(
        PutOutboundRequestBatchOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
