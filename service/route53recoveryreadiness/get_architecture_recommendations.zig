const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Recommendation = @import("recommendation.zig").Recommendation;

pub const GetArchitectureRecommendationsInput = struct {
    /// The number of objects that you want to return with this call.
    max_results: ?i32 = null,

    /// The token that identifies which batch of results you want to see.
    next_token: ?[]const u8 = null,

    /// The name of a recovery group.
    recovery_group_name: []const u8,

    pub const json_field_names = .{
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .recovery_group_name = "RecoveryGroupName",
    };
};

pub const GetArchitectureRecommendationsOutput = struct {
    /// The time that a recovery group was last assessed for recommendations, in UTC
    /// ISO-8601 format.
    last_audit_timestamp: ?i64 = null,

    /// The token that identifies which batch of results you want to see.
    next_token: ?[]const u8 = null,

    /// A list of the recommendations for the customer's application.
    recommendations: ?[]const Recommendation = null,

    pub const json_field_names = .{
        .last_audit_timestamp = "LastAuditTimestamp",
        .next_token = "NextToken",
        .recommendations = "Recommendations",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetArchitectureRecommendationsInput, options: CallOptions) !GetArchitectureRecommendationsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "route53-recovery-readiness", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetArchitectureRecommendationsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("route53-recovery-readiness", "Route53 Recovery Readiness", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/recoverygroups/");
    try path_buf.appendSlice(allocator, input.recovery_group_name);
    try path_buf.appendSlice(allocator, "/architectureRecommendations");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetArchitectureRecommendationsOutput {
    var result: GetArchitectureRecommendationsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetArchitectureRecommendationsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
