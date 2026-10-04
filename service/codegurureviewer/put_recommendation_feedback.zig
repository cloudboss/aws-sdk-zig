const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Reaction = @import("reaction.zig").Reaction;

pub const PutRecommendationFeedbackInput = struct {
    /// The Amazon Resource Name (ARN) of the
    /// [CodeReview](https://docs.aws.amazon.com/codeguru/latest/reviewer-api/API_CodeReview.html) object.
    code_review_arn: []const u8,

    /// List for storing reactions. Reactions are utf-8 text code for emojis. If you
    /// send an
    /// empty list it clears all your feedback.
    reactions: []const Reaction,

    /// The recommendation ID that can be used to track the provided recommendations
    /// and then to
    /// collect the feedback.
    recommendation_id: []const u8,

    pub const json_field_names = .{
        .code_review_arn = "CodeReviewArn",
        .reactions = "Reactions",
        .recommendation_id = "RecommendationId",
    };
};

pub const PutRecommendationFeedbackOutput = struct {
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutRecommendationFeedbackInput, options: CallOptions) !PutRecommendationFeedbackOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: PutRecommendationFeedbackInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("codeguru-reviewer", "CodeGuru Reviewer", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/feedback";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"CodeReviewArn\":");
    try aws.json.writeValue(@TypeOf(input.code_review_arn), input.code_review_arn, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Reactions\":");
    try aws.json.writeValue(@TypeOf(input.reactions), input.reactions, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"RecommendationId\":");
    try aws.json.writeValue(@TypeOf(input.recommendation_id), input.recommendation_id, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutRecommendationFeedbackOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: PutRecommendationFeedbackOutput = .{};

    return result;
}
