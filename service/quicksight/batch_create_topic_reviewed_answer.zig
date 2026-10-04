const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CreateTopicReviewedAnswer = @import("create_topic_reviewed_answer.zig").CreateTopicReviewedAnswer;
const InvalidTopicReviewedAnswer = @import("invalid_topic_reviewed_answer.zig").InvalidTopicReviewedAnswer;
const SucceededTopicReviewedAnswer = @import("succeeded_topic_reviewed_answer.zig").SucceededTopicReviewedAnswer;

pub const BatchCreateTopicReviewedAnswerInput = struct {
    /// The definition of the Answers to be created.
    answers: []const CreateTopicReviewedAnswer,

    /// The ID of the Amazon Web Services account that you want to create a reviewed
    /// answer in.
    aws_account_id: []const u8,

    /// The ID for the topic reviewed answer that you want to create. This ID is
    /// unique per Amazon Web Services Region for each Amazon Web Services account.
    topic_id: []const u8,

    pub const json_field_names = .{
        .answers = "Answers",
        .aws_account_id = "AwsAccountId",
        .topic_id = "TopicId",
    };
};

pub const BatchCreateTopicReviewedAnswerOutput = struct {
    /// The definition of Answers that are invalid and not created.
    invalid_answers: ?[]const InvalidTopicReviewedAnswer = null,

    /// The Amazon Web Services request ID for this operation.
    request_id: ?[]const u8 = null,

    /// The HTTP status of the request.
    status: ?i32 = null,

    /// The definition of Answers that are successfully created.
    succeeded_answers: ?[]const SucceededTopicReviewedAnswer = null,

    /// The Amazon Resource Name (ARN) of the topic.
    topic_arn: ?[]const u8 = null,

    /// The ID for the topic reviewed answer that you want to create. This ID is
    /// unique per Amazon Web Services Region
    /// for each Amazon Web Services account.
    topic_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .invalid_answers = "InvalidAnswers",
        .request_id = "RequestId",
        .status = "Status",
        .succeeded_answers = "SucceededAnswers",
        .topic_arn = "TopicArn",
        .topic_id = "TopicId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: BatchCreateTopicReviewedAnswerInput, options: CallOptions) !BatchCreateTopicReviewedAnswerOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "quicksight", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: BatchCreateTopicReviewedAnswerInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("quicksight", "QuickSight", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/accounts/");
    try path_buf.appendSlice(allocator, input.aws_account_id);
    try path_buf.appendSlice(allocator, "/topics/");
    try path_buf.appendSlice(allocator, input.topic_id);
    try path_buf.appendSlice(allocator, "/batch-create-reviewed-answers");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Answers\":");
    try aws.json.writeValue(@TypeOf(input.answers), input.answers, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !BatchCreateTopicReviewedAnswerOutput {
    var result: BatchCreateTopicReviewedAnswerOutput = try aws.json.parseJsonObject(
        BatchCreateTopicReviewedAnswerOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    result.status = @intCast(status);
    _ = headers;

    return result;
}
