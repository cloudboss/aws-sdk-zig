const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ReviewTemplateLensReview = @import("review_template_lens_review.zig").ReviewTemplateLensReview;

pub const UpdateReviewTemplateLensReviewInput = struct {
    lens_alias: []const u8,

    lens_notes: ?[]const u8 = null,

    pillar_notes: ?[]const aws.map.StringMapEntry = null,

    /// The review template ARN.
    template_arn: []const u8,

    pub const json_field_names = .{
        .lens_alias = "LensAlias",
        .lens_notes = "LensNotes",
        .pillar_notes = "PillarNotes",
        .template_arn = "TemplateArn",
    };
};

pub const UpdateReviewTemplateLensReviewOutput = struct {
    /// A lens review of a question.
    lens_review: ?ReviewTemplateLensReview = null,

    /// The review template ARN.
    template_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .lens_review = "LensReview",
        .template_arn = "TemplateArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateReviewTemplateLensReviewInput, options: CallOptions) !UpdateReviewTemplateLensReviewOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateReviewTemplateLensReviewInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("wellarchitected", "WellArchitected", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/reviewTemplates/");
    try path_buf.appendSlice(allocator, input.template_arn);
    try path_buf.appendSlice(allocator, "/lensReviews/");
    try path_buf.appendSlice(allocator, input.lens_alias);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.lens_notes) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"LensNotes\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.pillar_notes) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"PillarNotes\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PATCH;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateReviewTemplateLensReviewOutput {
    var result: UpdateReviewTemplateLensReviewOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateReviewTemplateLensReviewOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
