const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const TestRunStatus = @import("test_run_status.zig").TestRunStatus;

pub const StopTestRunInput = struct {
    /// The ARN of the service the test run belongs to.
    service_arn: []const u8,

    /// The identifier of the test run to stop.
    test_run_id: []const u8,

    pub const json_field_names = .{
        .service_arn = "serviceArn",
        .test_run_id = "testRunId",
    };
};

pub const StopTestRunOutput = struct {
    /// The status of the test run.
    status: TestRunStatus,

    /// The identifier of the stopped test run.
    test_run_id: []const u8,

    pub const json_field_names = .{
        .status = "status",
        .test_run_id = "testRunId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StopTestRunInput, options: CallOptions) !StopTestRunOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "resiliencehub", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: StopTestRunInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("resiliencehub", "resiliencehubv2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/v2/stop-test-run";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"serviceArn\":");
    try aws.json.writeValue(@TypeOf(input.service_arn), input.service_arn, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"testRunId\":");
    try aws.json.writeValue(@TypeOf(input.test_run_id), input.test_run_id, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StopTestRunOutput {
    const result: StopTestRunOutput = try aws.json.parseJsonObject(
        StopTestRunOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
