const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AssessmentResult = @import("assessment_result.zig").AssessmentResult;
const AssessmentTargetSummary = @import("assessment_target_summary.zig").AssessmentTargetSummary;
const ControlAssessment = @import("control_assessment.zig").ControlAssessment;
const FrameworkSummary = @import("framework_summary.zig").FrameworkSummary;

pub const DescribeAssessmentInput = struct {
    /// The unique identifier of the assessment to describe. You can provide either
    /// the assessment ID (for example, `assessment-12345`) or the full
    /// assessment ARN (for example,
    /// `arn:aws:aws-marketplace:us-east-1::AWSMarketplace/Assessment/assessment-12345`).
    assessment_identifier: []const u8,

    /// The catalog related to the request. Fixed value: `AWSMarketplace`
    catalog: []const u8,

    /// Specifies the upper limit of `ControlAssessment` elements returned on a
    /// single page. If a value isn't provided, the default value is 50. Valid
    /// values range
    /// from 1 to 100.
    max_results: ?i32 = null,

    /// The value of the next token, if it exists. `null` if there are no more
    /// results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .assessment_identifier = "AssessmentIdentifier",
        .catalog = "Catalog",
        .max_results = "MaxResults",
        .next_token = "NextToken",
    };
};

pub const DescribeAssessmentOutput = struct {
    /// The ARN associated with the assessment.
    assessment_arn: ?[]const u8 = null,

    /// The unique ID of the assessment.
    assessment_id: ?[]const u8 = null,

    /// The overall result of the assessment.
    assessment_result: ?AssessmentResult = null,

    /// Identifies the entity or change set that was assessed.
    assessment_target_summary: ?AssessmentTargetSummary = null,

    /// An array of `ControlAssessment` objects, each containing the result of an
    /// individual control evaluated as part of the assessment.
    control_assessments: ?[]const ControlAssessment = null,

    /// The date and time the assessment was created, in ISO 8601 format
    /// (`2018-02-27T13:45:22Z`).
    created_at: ?[]const u8 = null,

    /// The date and time the assessment expires, in ISO 8601 format
    /// (`2018-02-27T13:45:22Z`).
    expires_at: ?[]const u8 = null,

    /// The identifier of the framework that was evaluated by this assessment, in
    /// the format
    /// `frameworkId@version` (for example,
    /// `AMISecurity@1.0`).
    framework_id: ?[]const u8 = null,

    /// The framework-specific details of the assessed resource. The set member
    /// corresponds
    /// to the framework identified by `FrameworkId`.
    framework_summary: ?FrameworkSummary = null,

    /// The value of the next token, if it exists. `null` if there are no more
    /// results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .assessment_arn = "AssessmentArn",
        .assessment_id = "AssessmentId",
        .assessment_result = "AssessmentResult",
        .assessment_target_summary = "AssessmentTargetSummary",
        .control_assessments = "ControlAssessments",
        .created_at = "CreatedAt",
        .expires_at = "ExpiresAt",
        .framework_id = "FrameworkId",
        .framework_summary = "FrameworkSummary",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeAssessmentInput, options: CallOptions) !DescribeAssessmentOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "aws-marketplace", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeAssessmentInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("catalog.marketplace", "Marketplace Catalog", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/DescribeAssessment";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"AssessmentIdentifier\":");
    try aws.json.writeValue(@TypeOf(input.assessment_identifier), input.assessment_identifier, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Catalog\":");
    try aws.json.writeValue(@TypeOf(input.catalog), input.catalog, allocator, &body_buf);
    has_prev = true;
    if (input.max_results) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"MaxResults\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.next_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"NextToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeAssessmentOutput {
    const result: DescribeAssessmentOutput = try aws.json.parseJsonObject(
        DescribeAssessmentOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
