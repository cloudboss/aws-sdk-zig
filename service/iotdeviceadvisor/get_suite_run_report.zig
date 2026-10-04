const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const GetSuiteRunReportInput = struct {
    /// Suite definition ID of the test suite.
    suite_definition_id: []const u8,

    /// Suite run ID of the test suite run.
    suite_run_id: []const u8,

    pub const json_field_names = .{
        .suite_definition_id = "suiteDefinitionId",
        .suite_run_id = "suiteRunId",
    };
};

pub const GetSuiteRunReportOutput = struct {
    /// Download URL of the qualification report.
    qualification_report_download_url: ?[]const u8 = null,

    pub const json_field_names = .{
        .qualification_report_download_url = "qualificationReportDownloadUrl",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetSuiteRunReportInput, options: CallOptions) !GetSuiteRunReportOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "iotdeviceadvisor", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetSuiteRunReportInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("api.iotdeviceadvisor", "IotDeviceAdvisor", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/suiteDefinitions/");
    try path_buf.appendSlice(allocator, input.suite_definition_id);
    try path_buf.appendSlice(allocator, "/suiteRuns/");
    try path_buf.appendSlice(allocator, input.suite_run_id);
    try path_buf.appendSlice(allocator, "/report");
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetSuiteRunReportOutput {
    var result: GetSuiteRunReportOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetSuiteRunReportOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
