const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RecommendationPillar = @import("recommendation_pillar.zig").RecommendationPillar;
const RecommendationSource = @import("recommendation_source.zig").RecommendationSource;
const RecommendationStatus = @import("recommendation_status.zig").RecommendationStatus;
const RecommendationType = @import("recommendation_type.zig").RecommendationType;
const OrganizationRecommendationSummary = @import("organization_recommendation_summary.zig").OrganizationRecommendationSummary;

pub const ListOrganizationRecommendationsInput = struct {
    /// After the last update of the Recommendation
    after_last_updated_at: ?i64 = null,

    /// The aws service associated with the Recommendation
    aws_service: ?[]const u8 = null,

    /// Before the last update of the Recommendation
    before_last_updated_at: ?i64 = null,

    /// The check identifier of the Recommendation
    check_identifier: ?[]const u8 = null,

    /// The maximum number of results to return per page.
    max_results: ?i32 = null,

    /// The token for the next set of results. Use the value returned in the
    /// previous response in the next request to retrieve the next set of results.
    next_token: ?[]const u8 = null,

    /// The pillar of the Recommendation
    pillar: ?RecommendationPillar = null,

    /// The source of the Recommendation
    source: ?RecommendationSource = null,

    /// The status of the Recommendation
    status: ?RecommendationStatus = null,

    /// The type of the Recommendation
    type: ?RecommendationType = null,

    pub const json_field_names = .{
        .after_last_updated_at = "afterLastUpdatedAt",
        .aws_service = "awsService",
        .before_last_updated_at = "beforeLastUpdatedAt",
        .check_identifier = "checkIdentifier",
        .max_results = "maxResults",
        .next_token = "nextToken",
        .pillar = "pillar",
        .source = "source",
        .status = "status",
        .type = "type",
    };
};

pub const ListOrganizationRecommendationsOutput = struct {
    /// The token for the next set of results. Use the value returned in the
    /// previous response in the next request to retrieve the next set of results.
    next_token: ?[]const u8 = null,

    /// The list of Recommendations
    organization_recommendation_summaries: ?[]const OrganizationRecommendationSummary = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .organization_recommendation_summaries = "organizationRecommendationSummaries",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListOrganizationRecommendationsInput, options: CallOptions) !ListOrganizationRecommendationsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "trustedadvisor", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListOrganizationRecommendationsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("trustedadvisor", "TrustedAdvisor", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/v1/organization-recommendations";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.after_last_updated_at) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "afterLastUpdatedAt=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (input.aws_service) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "awsService=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.before_last_updated_at) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "beforeLastUpdatedAt=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (input.check_identifier) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "checkIdentifier=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
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
    if (input.pillar) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "pillar=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v.wireName());
        query_has_prev = true;
    }
    if (input.source) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "source=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v.wireName());
        query_has_prev = true;
    }
    if (input.status) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "status=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v.wireName());
        query_has_prev = true;
    }
    if (input.type) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "type=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v.wireName());
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListOrganizationRecommendationsOutput {
    const result: ListOrganizationRecommendationsOutput = try aws.json.parseJsonObject(
        ListOrganizationRecommendationsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
