const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ReviewTemplateAnswerSummary = @import("review_template_answer_summary.zig").ReviewTemplateAnswerSummary;

pub const ListReviewTemplateAnswersInput = struct {
    lens_alias: []const u8,

    /// The maximum number of results to return for this request.
    max_results: ?i32 = null,

    next_token: ?[]const u8 = null,

    pillar_id: ?[]const u8 = null,

    /// The ARN of the review template.
    template_arn: []const u8,

    pub const json_field_names = .{
        .lens_alias = "LensAlias",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .pillar_id = "PillarId",
        .template_arn = "TemplateArn",
    };
};

pub const ListReviewTemplateAnswersOutput = struct {
    /// List of answer summaries of a lens review in a review template.
    answer_summaries: ?[]const ReviewTemplateAnswerSummary = null,

    lens_alias: ?[]const u8 = null,

    next_token: ?[]const u8 = null,

    /// The ARN of the review template.
    template_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .answer_summaries = "AnswerSummaries",
        .lens_alias = "LensAlias",
        .next_token = "NextToken",
        .template_arn = "TemplateArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListReviewTemplateAnswersInput, options: CallOptions) !ListReviewTemplateAnswersOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListReviewTemplateAnswersInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("wellarchitected", "WellArchitected", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/reviewTemplates/");
    try path_buf.appendSlice(allocator, input.template_arn);
    try path_buf.appendSlice(allocator, "/lensReviews/");
    try path_buf.appendSlice(allocator, input.lens_alias);
    try path_buf.appendSlice(allocator, "/answers");
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
    if (input.pillar_id) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "PillarId=");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListReviewTemplateAnswersOutput {
    const result: ListReviewTemplateAnswersOutput = try aws.json.parseJsonObject(
        ListReviewTemplateAnswersOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
