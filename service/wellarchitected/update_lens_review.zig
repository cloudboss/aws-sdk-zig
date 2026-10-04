const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const JiraSelectedQuestionConfiguration = @import("jira_selected_question_configuration.zig").JiraSelectedQuestionConfiguration;
const LensReview = @import("lens_review.zig").LensReview;

pub const UpdateLensReviewInput = struct {
    /// Configuration of the Jira integration.
    jira_configuration: ?JiraSelectedQuestionConfiguration = null,

    lens_alias: []const u8,

    lens_notes: ?[]const u8 = null,

    pillar_notes: ?[]const aws.map.StringMapEntry = null,

    workload_id: []const u8,

    pub const json_field_names = .{
        .jira_configuration = "JiraConfiguration",
        .lens_alias = "LensAlias",
        .lens_notes = "LensNotes",
        .pillar_notes = "PillarNotes",
        .workload_id = "WorkloadId",
    };
};

pub const UpdateLensReviewOutput = struct {
    lens_review: ?LensReview = null,

    workload_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .lens_review = "LensReview",
        .workload_id = "WorkloadId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateLensReviewInput, options: CallOptions) !UpdateLensReviewOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateLensReviewInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("wellarchitected", "WellArchitected", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/workloads/");
    try path_buf.appendSlice(allocator, input.workload_id);
    try path_buf.appendSlice(allocator, "/lensReviews/");
    try path_buf.appendSlice(allocator, input.lens_alias);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.jira_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"JiraConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateLensReviewOutput {
    const result: UpdateLensReviewOutput = try aws.json.parseJsonObject(
        UpdateLensReviewOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
