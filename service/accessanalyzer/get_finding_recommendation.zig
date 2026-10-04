const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RecommendationError = @import("recommendation_error.zig").RecommendationError;
const RecommendationType = @import("recommendation_type.zig").RecommendationType;
const RecommendedStep = @import("recommended_step.zig").RecommendedStep;
const Status = @import("status.zig").Status;

pub const GetFindingRecommendationInput = struct {
    /// The [ARN of the
    /// analyzer](https://docs.aws.amazon.com/IAM/latest/UserGuide/access-analyzer-getting-started.html#permission-resources) used to generate the finding recommendation.
    analyzer_arn: []const u8,

    /// The unique ID for the finding recommendation.
    id: []const u8,

    /// The maximum number of results to return in the response.
    max_results: ?i32 = null,

    /// A token used for pagination of results returned.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .analyzer_arn = "analyzerArn",
        .id = "id",
        .max_results = "maxResults",
        .next_token = "nextToken",
    };
};

pub const GetFindingRecommendationOutput = struct {
    /// The time at which the retrieval of the finding recommendation was completed.
    completed_at: ?i64 = null,

    /// Detailed information about the reason that the retrieval of a recommendation
    /// for the finding failed.
    @"error": ?RecommendationError = null,

    /// A token used for pagination of results returned.
    next_token: ?[]const u8 = null,

    /// The type of recommendation for the finding.
    recommendation_type: RecommendationType,

    /// A group of recommended steps for the finding.
    recommended_steps: ?[]const RecommendedStep = null,

    /// The ARN of the resource of the finding.
    resource_arn: []const u8,

    /// The time at which the retrieval of the finding recommendation was started.
    started_at: i64,

    /// The status of the retrieval of the finding recommendation.
    status: Status,

    pub const json_field_names = .{
        .completed_at = "completedAt",
        .@"error" = "error",
        .next_token = "nextToken",
        .recommendation_type = "recommendationType",
        .recommended_steps = "recommendedSteps",
        .resource_arn = "resourceArn",
        .started_at = "startedAt",
        .status = "status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetFindingRecommendationInput, options: CallOptions) !GetFindingRecommendationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "access-analyzer", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetFindingRecommendationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("access-analyzer", "AccessAnalyzer", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/recommendation/");
    try path_buf.appendSlice(allocator, input.id);
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "analyzerArn=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.analyzer_arn);
    query_has_prev = true;
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetFindingRecommendationOutput {
    var result: GetFindingRecommendationOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetFindingRecommendationOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
