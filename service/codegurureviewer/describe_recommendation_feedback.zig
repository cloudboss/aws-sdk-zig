const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RecommendationFeedback = @import("recommendation_feedback.zig").RecommendationFeedback;

pub const DescribeRecommendationFeedbackInput = struct {
    /// The Amazon Resource Name (ARN) of the
    /// [CodeReview](https://docs.aws.amazon.com/codeguru/latest/reviewer-api/API_CodeReview.html) object.
    code_review_arn: []const u8,

    /// The recommendation ID that can be used to track the provided recommendations
    /// and then to
    /// collect the feedback.
    recommendation_id: []const u8,

    /// Optional parameter to describe the feedback for a given user. If this is not
    /// supplied,
    /// it defaults to the user making the request.
    ///
    /// The `UserId` is an IAM principal that can be specified as an Amazon Web
    /// Services account ID or an Amazon Resource Name (ARN). For
    /// more information, see [
    /// Specifying a
    /// Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_policies_elements_principal.html#Principal_specifying) in the *Amazon Web Services Identity and Access Management User Guide*.
    user_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .code_review_arn = "CodeReviewArn",
        .recommendation_id = "RecommendationId",
        .user_id = "UserId",
    };
};

pub const DescribeRecommendationFeedbackOutput = struct {
    /// The recommendation feedback given by the user.
    recommendation_feedback: ?RecommendationFeedback = null,

    pub const json_field_names = .{
        .recommendation_feedback = "RecommendationFeedback",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeRecommendationFeedbackInput, options: CallOptions) !DescribeRecommendationFeedbackOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeRecommendationFeedbackInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("codeguru-reviewer", "CodeGuru Reviewer", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/feedback/");
    try path_buf.appendSlice(allocator, input.code_review_arn);
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "RecommendationId=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.recommendation_id);
    query_has_prev = true;
    if (input.user_id) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "UserId=");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeRecommendationFeedbackOutput {
    const result: DescribeRecommendationFeedbackOutput = try aws.json.parseJsonObject(
        DescribeRecommendationFeedbackOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
