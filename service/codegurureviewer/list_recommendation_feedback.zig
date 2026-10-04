const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RecommendationFeedbackSummary = @import("recommendation_feedback_summary.zig").RecommendationFeedbackSummary;

pub const ListRecommendationFeedbackInput = struct {
    /// The Amazon Resource Name (ARN) of the
    /// [CodeReview](https://docs.aws.amazon.com/codeguru/latest/reviewer-api/API_CodeReview.html) object.
    code_review_arn: []const u8,

    /// The maximum number of results that are returned per call. The default is
    /// 100.
    max_results: ?i32 = null,

    /// If `nextToken` is returned, there are more results available. The value of
    /// `nextToken` is a unique pagination token for each page. Make the call again
    /// using the returned token to retrieve the next page. Keep all other arguments
    /// unchanged.
    next_token: ?[]const u8 = null,

    /// Used to query the recommendation feedback for a given recommendation.
    recommendation_ids: ?[]const []const u8 = null,

    /// An Amazon Web Services user's account ID or Amazon Resource Name (ARN). Use
    /// this ID to query the
    /// recommendation feedback for a code review from that user.
    ///
    /// The `UserId` is an IAM principal that can be specified as an Amazon Web
    /// Services account ID or an Amazon Resource Name (ARN). For
    /// more information, see [
    /// Specifying a
    /// Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_policies_elements_principal.html#Principal_specifying) in the *Amazon Web Services Identity and Access Management User Guide*.
    user_ids: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .code_review_arn = "CodeReviewArn",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .recommendation_ids = "RecommendationIds",
        .user_ids = "UserIds",
    };
};

pub const ListRecommendationFeedbackOutput = struct {
    /// If `nextToken` is returned, there are more results available. The value of
    /// `nextToken` is a unique pagination token for each page. Make the call again
    /// using the returned token to retrieve the next page. Keep all other arguments
    /// unchanged.
    next_token: ?[]const u8 = null,

    /// Recommendation feedback summaries corresponding to the code review ARN.
    recommendation_feedback_summaries: ?[]const RecommendationFeedbackSummary = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .recommendation_feedback_summaries = "RecommendationFeedbackSummaries",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListRecommendationFeedbackInput, options: CallOptions) !ListRecommendationFeedbackOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "codeguru-reviewer", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListRecommendationFeedbackInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("codeguru-reviewer", "CodeGuru Reviewer", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/feedback/");
    try path_buf.appendSlice(allocator, input.code_review_arn);
    try path_buf.appendSlice(allocator, "/RecommendationFeedback");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.max_results) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "MaxResults=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (input.next_token) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "NextToken=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.recommendation_ids) |v| {
        for (v) |item| {
            if (query_has_prev) try query_buf.appendSlice(allocator, "&");
            try query_buf.appendSlice(allocator, "RecommendationIds=");
            try aws.url.appendUrlEncoded(allocator, &query_buf, item);
            query_has_prev = true;
        }
    }
    if (input.user_ids) |v| {
        for (v) |item| {
            if (query_has_prev) try query_buf.appendSlice(allocator, "&");
            try query_buf.appendSlice(allocator, "UserIds=");
            try aws.url.appendUrlEncoded(allocator, &query_buf, item);
            query_has_prev = true;
        }
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListRecommendationFeedbackOutput {
    const result: ListRecommendationFeedbackOutput = try aws.json.parseJsonObject(
        ListRecommendationFeedbackOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
