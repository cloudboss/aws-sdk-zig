const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const TestCaseEntryPoint = @import("test_case_entry_point.zig").TestCaseEntryPoint;
const TestCaseStatus = @import("test_case_status.zig").TestCaseStatus;

pub const UpdateTestCaseInput = struct {
    /// The JSON string that represents the content of the test.
    content: ?[]const u8 = null,

    /// The description of the test case.
    description: ?[]const u8 = null,

    /// Defines the starting point for your test.
    entry_point: ?TestCaseEntryPoint = null,

    /// Defines the test attributes for precise data representation.
    initialization_data: ?[]const u8 = null,

    /// The identifier of the Amazon Connect instance.
    instance_id: []const u8,

    /// The region in which the resource was last modified
    last_modified_region: ?[]const u8 = null,

    /// The time at which the resource was last modified.
    last_modified_time: ?i64 = null,

    /// The name of the test case.
    name: ?[]const u8 = null,

    /// Indicates the test status as either SAVED or PUBLISHED. The PUBLISHED status
    /// will initiate validation on the content. The SAVED status does not initiate
    /// validation of the content.
    status: ?TestCaseStatus = null,

    /// The identifier of the test case to update.
    test_case_id: []const u8,

    pub const json_field_names = .{
        .content = "Content",
        .description = "Description",
        .entry_point = "EntryPoint",
        .initialization_data = "InitializationData",
        .instance_id = "InstanceId",
        .last_modified_region = "LastModifiedRegion",
        .last_modified_time = "LastModifiedTime",
        .name = "Name",
        .status = "Status",
        .test_case_id = "TestCaseId",
    };
};

pub const UpdateTestCaseOutput = struct {
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateTestCaseInput, options: CallOptions) !UpdateTestCaseOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateTestCaseInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("connect", "Connect", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/test-cases/");
    try path_buf.appendSlice(allocator, input.instance_id);
    try path_buf.appendSlice(allocator, "/");
    try path_buf.appendSlice(allocator, input.test_case_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.content) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Content\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.entry_point) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"EntryPoint\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.initialization_data) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"InitializationData\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Name\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.status) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Status\":");
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
    if (input.last_modified_region) |v| {
        try request.headers.put(allocator, "x-amz-last-modified-region", v);
    }
    if (input.last_modified_time) |v| {
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try request.headers.put(allocator, "x-amz-last-modified-time", num_str);
        }
    }

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateTestCaseOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: UpdateTestCaseOutput = .{};

    return result;
}
