const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const TestCaseStatus = @import("test_case_status.zig").TestCaseStatus;
const TestCase = @import("test_case.zig").TestCase;

pub const DescribeTestCaseInput = struct {
    /// The identifier of the Amazon Connect instance.
    instance_id: []const u8,

    /// The status of the test case version to retrieve. If not specified, returns
    /// the published version if available, otherwise returns the saved version.
    status: ?TestCaseStatus = null,

    /// The identifier of the test case.
    test_case_id: []const u8,

    pub const json_field_names = .{
        .instance_id = "InstanceId",
        .status = "Status",
        .test_case_id = "TestCaseId",
    };
};

pub const DescribeTestCaseOutput = struct {
    /// The test case object containing all test case information.
    test_case: ?TestCase = null,

    pub const json_field_names = .{
        .test_case = "TestCase",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeTestCaseInput, options: CallOptions) !DescribeTestCaseOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "connect", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeTestCaseInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("connect", "Connect", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/test-cases/");
    try path_buf.appendSlice(allocator, input.instance_id);
    try path_buf.appendSlice(allocator, "/");
    try path_buf.appendSlice(allocator, input.test_case_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.status) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "status=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v.wireName());
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeTestCaseOutput {
    var result: DescribeTestCaseOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(DescribeTestCaseOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
