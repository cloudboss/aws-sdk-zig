const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ServiceLevelObjectiveBudgetReportError = @import("service_level_objective_budget_report_error.zig").ServiceLevelObjectiveBudgetReportError;
const ServiceLevelObjectiveBudgetReport = @import("service_level_objective_budget_report.zig").ServiceLevelObjectiveBudgetReport;

pub const BatchGetServiceLevelObjectiveBudgetReportInput = struct {
    /// An array containing the IDs of the service level objectives that you want to
    /// include in the report.
    slo_ids: []const []const u8,

    /// The date and time that you want the report to be for. It is expressed as the
    /// number of milliseconds since Jan 1, 1970 00:00:00 UTC.
    timestamp: i64,

    pub const json_field_names = .{
        .slo_ids = "SloIds",
        .timestamp = "Timestamp",
    };
};

pub const BatchGetServiceLevelObjectiveBudgetReportOutput = struct {
    /// An array of structures, where each structure includes an error indicating
    /// that one of the requests in the array was not valid.
    errors: ?[]const ServiceLevelObjectiveBudgetReportError = null,

    /// An array of structures, where each structure is one budget report.
    reports: ?[]const ServiceLevelObjectiveBudgetReport = null,

    /// The date and time that the report is for. It is expressed as the number of
    /// milliseconds since Jan 1, 1970 00:00:00 UTC.
    timestamp: i64,

    pub const json_field_names = .{
        .errors = "Errors",
        .reports = "Reports",
        .timestamp = "Timestamp",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: BatchGetServiceLevelObjectiveBudgetReportInput, options: CallOptions) !BatchGetServiceLevelObjectiveBudgetReportOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "application-signals", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: BatchGetServiceLevelObjectiveBudgetReportInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("application-signals", "Application Signals", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/budget-report";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"SloIds\":");
    try aws.json.writeValue(@TypeOf(input.slo_ids), input.slo_ids, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Timestamp\":");
    try aws.json.writeValue(@TypeOf(input.timestamp), input.timestamp, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !BatchGetServiceLevelObjectiveBudgetReportOutput {
    const result: BatchGetServiceLevelObjectiveBudgetReportOutput = try aws.json.parseJsonObject(
        BatchGetServiceLevelObjectiveBudgetReportOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
