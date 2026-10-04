const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const TestSetDiscrepancyReportResourceTarget = @import("test_set_discrepancy_report_resource_target.zig").TestSetDiscrepancyReportResourceTarget;

pub const CreateTestSetDiscrepancyReportInput = struct {
    /// The target bot for the test set discrepancy report.
    target: TestSetDiscrepancyReportResourceTarget,

    /// The test set Id for the test set discrepancy report.
    test_set_id: []const u8,

    pub const json_field_names = .{
        .target = "target",
        .test_set_id = "testSetId",
    };
};

pub const CreateTestSetDiscrepancyReportOutput = struct {
    /// The creation date and time for the test set discrepancy report.
    creation_date_time: ?i64 = null,

    /// The target bot for the test set discrepancy report.
    target: ?TestSetDiscrepancyReportResourceTarget = null,

    /// The unique identifier of the test set discrepancy report to describe.
    test_set_discrepancy_report_id: ?[]const u8 = null,

    /// The test set Id for the test set discrepancy report.
    test_set_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .creation_date_time = "creationDateTime",
        .target = "target",
        .test_set_discrepancy_report_id = "testSetDiscrepancyReportId",
        .test_set_id = "testSetId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateTestSetDiscrepancyReportInput, options: CallOptions) !CreateTestSetDiscrepancyReportOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "lex", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateTestSetDiscrepancyReportInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("models-v2-lex", "Lex Models V2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/testsets/");
    try path_buf.appendSlice(allocator, input.test_set_id);
    try path_buf.appendSlice(allocator, "/testsetdiscrepancy");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"target\":");
    try aws.json.writeValue(@TypeOf(input.target), input.target, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateTestSetDiscrepancyReportOutput {
    const result: CreateTestSetDiscrepancyReportOutput = try aws.json.parseJsonObject(
        CreateTestSetDiscrepancyReportOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
