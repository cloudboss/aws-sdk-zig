const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CodeReviewType = @import("code_review_type.zig").CodeReviewType;
const CodeReview = @import("code_review.zig").CodeReview;

pub const CreateCodeReviewInput = struct {
    /// Amazon CodeGuru Reviewer uses this value to prevent the accidental creation
    /// of duplicate code reviews
    /// if there are failures and retries.
    client_request_token: ?[]const u8 = null,

    /// The name of the code review. The name of each code review in your Amazon Web
    /// Services account must be
    /// unique.
    name: []const u8,

    /// The Amazon Resource Name (ARN) of the
    /// [RepositoryAssociation](https://docs.aws.amazon.com/codeguru/latest/reviewer-api/API_RepositoryAssociation.html) object. You can retrieve this ARN by calling [ListRepositoryAssociations](https://docs.aws.amazon.com/codeguru/latest/reviewer-api/API_ListRepositoryAssociations.html).
    ///
    /// A code review can only be created on an associated repository. This is the
    /// ARN of the
    /// associated repository.
    repository_association_arn: []const u8,

    /// The type of code review to create. This is specified using a
    /// [CodeReviewType](https://docs.aws.amazon.com/codeguru/latest/reviewer-api/API_CodeReviewType.html)
    /// object. You can create a code review only of type `RepositoryAnalysis`.
    @"type": CodeReviewType,

    pub const json_field_names = .{
        .client_request_token = "ClientRequestToken",
        .name = "Name",
        .repository_association_arn = "RepositoryAssociationArn",
        .@"type" = "Type",
    };
};

pub const CreateCodeReviewOutput = struct {
    code_review: ?CodeReview = null,

    pub const json_field_names = .{
        .code_review = "CodeReview",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateCodeReviewInput, options: CallOptions) !CreateCodeReviewOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateCodeReviewInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("codeguru-reviewer", "CodeGuru Reviewer", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/codereviews";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.client_request_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ClientRequestToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"RepositoryAssociationArn\":");
    try aws.json.writeValue(@TypeOf(input.repository_association_arn), input.repository_association_arn, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Type\":");
    try aws.json.writeValue(@TypeOf(input.@"type"), input.@"type", allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateCodeReviewOutput {
    var result: CreateCodeReviewOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateCodeReviewOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
