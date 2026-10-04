const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ProfileOutboundRequest = @import("profile_outbound_request.zig").ProfileOutboundRequest;
const FailedProfileOutboundRequest = @import("failed_profile_outbound_request.zig").FailedProfileOutboundRequest;
const SuccessfulProfileOutboundRequest = @import("successful_profile_outbound_request.zig").SuccessfulProfileOutboundRequest;

pub const PutProfileOutboundRequestBatchInput = struct {
    id: []const u8,

    profile_outbound_requests: []const ProfileOutboundRequest,

    pub const json_field_names = .{
        .id = "id",
        .profile_outbound_requests = "profileOutboundRequests",
    };
};

pub const PutProfileOutboundRequestBatchOutput = struct {
    failed_requests: ?[]const FailedProfileOutboundRequest = null,

    successful_requests: ?[]const SuccessfulProfileOutboundRequest = null,

    pub const json_field_names = .{
        .failed_requests = "failedRequests",
        .successful_requests = "successfulRequests",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutProfileOutboundRequestBatchInput, options: CallOptions) !PutProfileOutboundRequestBatchOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: PutProfileOutboundRequestBatchInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("connect-campaigns", "ConnectCampaignsV2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v2/campaigns/");
    try path_buf.appendSlice(allocator, input.id);
    try path_buf.appendSlice(allocator, "/profile-outbound-requests");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"profileOutboundRequests\":");
    try aws.json.writeValue(@TypeOf(input.profile_outbound_requests), input.profile_outbound_requests, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutProfileOutboundRequestBatchOutput {
    const result: PutProfileOutboundRequestBatchOutput = try aws.json.parseJsonObject(
        PutProfileOutboundRequestBatchOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
