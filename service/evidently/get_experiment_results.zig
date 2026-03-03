const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const ExperimentBaseStat = @import("experiment_base_stat.zig").ExperimentBaseStat;
const ExperimentReportName = @import("experiment_report_name.zig").ExperimentReportName;
const ExperimentResultRequestType = @import("experiment_result_request_type.zig").ExperimentResultRequestType;
const ExperimentReport = @import("experiment_report.zig").ExperimentReport;
const ExperimentResultsData = @import("experiment_results_data.zig").ExperimentResultsData;

pub const GetExperimentResultsInput = struct {
    /// The statistic used to calculate experiment results. Currently the only valid
    /// value is `mean`, which uses the mean of the collected values as the
    /// statistic.
    base_stat: ?ExperimentBaseStat = null,

    /// The date and time that the experiment ended, if it is completed. This must
    /// be no longer than 30 days after the experiment start time.
    end_time: ?i64 = null,

    /// The name of the experiment to retrieve the results of.
    experiment: []const u8,

    /// The names of the experiment metrics that you want to see the results of.
    metric_names: []const []const u8,

    /// In seconds, the amount of time to aggregate results together.
    period: ?i64 = null,

    /// The name or ARN of the project that contains the experiment that you want to
    /// see the results of.
    project: []const u8,

    /// The names of the report types that you want to see. Currently,
    /// `BayesianInference` is the only valid value.
    report_names: ?[]const ExperimentReportName = null,

    /// The statistics that you want to see in the returned results.
    ///
    /// * `PValue` specifies to use p-values for the results. A p-value is used in
    ///   hypothesis testing to measure how often you are willing to make a mistake
    ///   in rejecting the null hypothesis. A general practice is to reject the null
    ///   hypothesis and declare that the results are statistically significant when
    ///   the p-value is less than 0.05.
    /// * `ConfidenceInterval` specifies a confidence interval for the results. The
    ///   confidence interval represents the range of values for the chosen metric
    ///   that is likely to contain the true difference between the `baseStat` of a
    ///   variation and the baseline. Evidently returns the 95% confidence interval.
    /// * `TreatmentEffect` is the difference in the statistic specified by the
    ///   `baseStat` parameter between each variation and the default variation.
    /// * `BaseStat` returns the statistical values collected for the metric for
    ///   each variation. The statistic uses the same statistic specified in the
    ///   `baseStat` parameter. Therefore, if `baseStat` is `mean`, this returns the
    ///   mean of the values collected for each variation.
    result_stats: ?[]const ExperimentResultRequestType = null,

    /// The date and time that the experiment started.
    start_time: ?i64 = null,

    /// The names of the experiment treatments that you want to see the results for.
    treatment_names: []const []const u8,

    pub const json_field_names = .{
        .base_stat = "baseStat",
        .end_time = "endTime",
        .experiment = "experiment",
        .metric_names = "metricNames",
        .period = "period",
        .project = "project",
        .report_names = "reportNames",
        .result_stats = "resultStats",
        .start_time = "startTime",
        .treatment_names = "treatmentNames",
    };
};

pub const GetExperimentResultsOutput = struct {
    /// If the experiment doesn't yet have enough events to provide valid results,
    /// this field is returned with the message `Not enough events to generate
    /// results`. If there are enough events to provide valid results, this field is
    /// not returned.
    details: ?[]const u8 = null,

    /// An array of structures that include the reports that you requested.
    reports: ?[]const ExperimentReport = null,

    /// An array of structures that include experiment results including metric
    /// names and values.
    results_data: ?[]const ExperimentResultsData = null,

    /// The timestamps of each result returned.
    timestamps: ?[]const i64 = null,

    pub const json_field_names = .{
        .details = "details",
        .reports = "reports",
        .results_data = "resultsData",
        .timestamps = "timestamps",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetExperimentResultsInput, options: Options) !GetExperimentResultsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "evidently");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: GetExperimentResultsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("evidently", "Evidently", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/projects/");
    try path_buf.appendSlice(allocator, input.project);
    try path_buf.appendSlice(allocator, "/experiments/");
    try path_buf.appendSlice(allocator, input.experiment);
    try path_buf.appendSlice(allocator, "/results");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.base_stat) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"baseStat\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.end_time) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"endTime\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"metricNames\":");
    try aws.json.writeValue(@TypeOf(input.metric_names), input.metric_names, allocator, &body_buf);
    has_prev = true;
    if (input.period) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"period\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.report_names) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"reportNames\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.result_stats) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"resultStats\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.start_time) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"startTime\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"treatmentNames\":");
    try aws.json.writeValue(@TypeOf(input.treatment_names), input.treatment_names, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetExperimentResultsOutput {
    var result: GetExperimentResultsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetExperimentResultsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "AccessDeniedException")) {
        return .{ .arena = arena, .kind = .{ .access_denied_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServerException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceQuotaExceededException")) {
        return .{ .arena = arena, .kind = .{ .service_quota_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceUnavailableException")) {
        return .{ .arena = arena, .kind = .{ .service_unavailable_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ThrottlingException")) {
        return .{ .arena = arena, .kind = .{ .throttling_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ValidationException")) {
        return .{ .arena = arena, .kind = .{ .validation_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
