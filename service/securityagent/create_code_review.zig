const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Assets = @import("assets.zig").Assets;
const CodeRemediationStrategy = @import("code_remediation_strategy.zig").CodeRemediationStrategy;
const CloudWatchLog = @import("cloud_watch_log.zig").CloudWatchLog;
const ReportDestination = @import("report_destination.zig").ReportDestination;
const ReportFilters = @import("report_filters.zig").ReportFilters;
const ValidationMode = @import("validation_mode.zig").ValidationMode;

pub const CreateCodeReviewInput = struct {
    /// The unique identifier of the agent space to create the code review in.
    agent_space_id: []const u8,

    /// The assets to include in the code review, such as documents and source code.
    assets: Assets,

    /// The code remediation strategy for the code review. Valid values are
    /// AUTOMATIC and DISABLED.
    code_remediation_strategy: ?CodeRemediationStrategy = null,

    /// The CloudWatch Logs configuration for the code review.
    log_config: ?CloudWatchLog = null,

    /// The maximum number of billable task hours allowed for jobs started from this
    /// code review. Must be a positive number. If not set, jobs run to completion
    /// with no budget cap.
    max_task_hours: ?f64 = null,

    /// The destination for publishing scan reports to an integrated document
    /// provider.
    report_destination: ?ReportDestination = null,

    /// The report-generation filters applied when the report is exported.
    report_filters: ?ReportFilters = null,

    /// The IAM service role to use for the code review.
    service_role: ?[]const u8 = null,

    /// The title of the code review.
    title: []const u8,

    /// The validation mode for the code review. Valid values are SIMULATED and
    /// DISABLED.
    validation_mode: ?ValidationMode = null,

    pub const json_field_names = .{
        .agent_space_id = "agentSpaceId",
        .assets = "assets",
        .code_remediation_strategy = "codeRemediationStrategy",
        .log_config = "logConfig",
        .max_task_hours = "maxTaskHours",
        .report_destination = "reportDestination",
        .report_filters = "reportFilters",
        .service_role = "serviceRole",
        .title = "title",
        .validation_mode = "validationMode",
    };
};

pub const CreateCodeReviewOutput = struct {
    /// The unique identifier of the agent space that contains the code review.
    agent_space_id: ?[]const u8 = null,

    /// The assets included in the code review.
    assets: ?Assets = null,

    /// The code remediation strategy for the code review.
    code_remediation_strategy: ?CodeRemediationStrategy = null,

    /// The unique identifier of the created code review.
    code_review_id: []const u8,

    /// The date and time the code review was created, in UTC format.
    created_at: ?i64 = null,

    /// The CloudWatch Logs configuration for the code review.
    log_config: ?CloudWatchLog = null,

    /// The maximum number of billable task hours configured for jobs started from
    /// this code review. Null if no budget cap is set.
    max_task_hours: ?f64 = null,

    /// The destination for publishing scan reports to an integrated document
    /// provider.
    report_destination: ?ReportDestination = null,

    /// The report-generation filters applied when the report is exported.
    report_filters: ?ReportFilters = null,

    /// The IAM service role used for the code review.
    service_role: ?[]const u8 = null,

    /// The title of the code review.
    title: ?[]const u8 = null,

    /// The date and time the code review was last updated, in UTC format.
    updated_at: ?i64 = null,

    /// The validation mode for the code review.
    validation_mode: ?ValidationMode = null,

    pub const json_field_names = .{
        .agent_space_id = "agentSpaceId",
        .assets = "assets",
        .code_remediation_strategy = "codeRemediationStrategy",
        .code_review_id = "codeReviewId",
        .created_at = "createdAt",
        .log_config = "logConfig",
        .max_task_hours = "maxTaskHours",
        .report_destination = "reportDestination",
        .report_filters = "reportFilters",
        .service_role = "serviceRole",
        .title = "title",
        .updated_at = "updatedAt",
        .validation_mode = "validationMode",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateCodeReviewInput, options: CallOptions) !CreateCodeReviewOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "securityagent", client.config.http_client.clock_skew_offset);

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
    const endpoint = try config.getEndpointForService("securityagent", "SecurityAgent", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/CreateCodeReview";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"agentSpaceId\":");
    try aws.json.writeValue(@TypeOf(input.agent_space_id), input.agent_space_id, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"assets\":");
    try aws.json.writeValue(@TypeOf(input.assets), input.assets, allocator, &body_buf);
    has_prev = true;
    if (input.code_remediation_strategy) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"codeRemediationStrategy\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.log_config) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"logConfig\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.max_task_hours) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"maxTaskHours\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.report_destination) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"reportDestination\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.report_filters) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"reportFilters\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.service_role) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"serviceRole\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"title\":");
    try aws.json.writeValue(@TypeOf(input.title), input.title, allocator, &body_buf);
    has_prev = true;
    if (input.validation_mode) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"validationMode\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateCodeReviewOutput {
    const result: CreateCodeReviewOutput = try aws.json.parseJsonObject(
        CreateCodeReviewOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
