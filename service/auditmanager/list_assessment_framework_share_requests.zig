const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ShareRequestType = @import("share_request_type.zig").ShareRequestType;
const AssessmentFrameworkShareRequest = @import("assessment_framework_share_request.zig").AssessmentFrameworkShareRequest;

pub const ListAssessmentFrameworkShareRequestsInput = struct {
    /// Represents the maximum number of results on a page or for an API request
    /// call.
    max_results: ?i32 = null,

    /// The pagination token that's used to fetch the next set of results.
    next_token: ?[]const u8 = null,

    /// Specifies whether the share request is a sent request or a received request.
    request_type: ShareRequestType,

    pub const json_field_names = .{
        .max_results = "maxResults",
        .next_token = "nextToken",
        .request_type = "requestType",
    };
};

pub const ListAssessmentFrameworkShareRequestsOutput = struct {
    /// The list of share requests that the `ListAssessmentFrameworkShareRequests`
    /// API returned.
    assessment_framework_share_requests: ?[]const AssessmentFrameworkShareRequest = null,

    /// The pagination token that's used to fetch the next set of results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .assessment_framework_share_requests = "assessmentFrameworkShareRequests",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListAssessmentFrameworkShareRequestsInput, options: CallOptions) !ListAssessmentFrameworkShareRequestsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "auditmanager", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListAssessmentFrameworkShareRequestsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("auditmanager", "AuditManager", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/assessmentFrameworkShareRequests";

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
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "requestType=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.request_type.wireName());
    query_has_prev = true;
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListAssessmentFrameworkShareRequestsOutput {
    var result: ListAssessmentFrameworkShareRequestsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListAssessmentFrameworkShareRequestsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
