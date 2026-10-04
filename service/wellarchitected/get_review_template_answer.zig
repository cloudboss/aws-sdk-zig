const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ReviewTemplateAnswer = @import("review_template_answer.zig").ReviewTemplateAnswer;

pub const GetReviewTemplateAnswerInput = struct {
    lens_alias: []const u8,

    question_id: []const u8,

    /// The review template ARN.
    template_arn: []const u8,

    pub const json_field_names = .{
        .lens_alias = "LensAlias",
        .question_id = "QuestionId",
        .template_arn = "TemplateArn",
    };
};

pub const GetReviewTemplateAnswerOutput = struct {
    /// An answer of the question.
    answer: ?ReviewTemplateAnswer = null,

    lens_alias: ?[]const u8 = null,

    /// The review template ARN.
    template_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .answer = "Answer",
        .lens_alias = "LensAlias",
        .template_arn = "TemplateArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetReviewTemplateAnswerInput, options: CallOptions) !GetReviewTemplateAnswerOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "wellarchitected", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetReviewTemplateAnswerInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("wellarchitected", "WellArchitected", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/reviewTemplates/");
    try path_buf.appendSlice(allocator, input.template_arn);
    try path_buf.appendSlice(allocator, "/lensReviews/");
    try path_buf.appendSlice(allocator, input.lens_alias);
    try path_buf.appendSlice(allocator, "/answers/");
    try path_buf.appendSlice(allocator, input.question_id);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetReviewTemplateAnswerOutput {
    var result: GetReviewTemplateAnswerOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetReviewTemplateAnswerOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
