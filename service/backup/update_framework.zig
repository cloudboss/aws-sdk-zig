const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const FrameworkControl = @import("framework_control.zig").FrameworkControl;

pub const UpdateFrameworkInput = struct {
    /// The controls that make up the framework. Each control in the list has a
    /// name,
    /// input parameters, and scope.
    framework_controls: ?[]const FrameworkControl = null,

    /// An optional description of the framework with a maximum 1,024 characters.
    framework_description: ?[]const u8 = null,

    /// The unique name of a framework. This name is between 1 and 256 characters,
    /// starting with
    /// a letter, and consisting of letters (a-z, A-Z), numbers (0-9), and
    /// underscores (_).
    framework_name: []const u8,

    /// A customer-chosen string that you can use to distinguish between otherwise
    /// identical
    /// calls to `UpdateFrameworkInput`. Retrying a successful request with the same
    /// idempotency token results in a success message with no action taken.
    idempotency_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .framework_controls = "FrameworkControls",
        .framework_description = "FrameworkDescription",
        .framework_name = "FrameworkName",
        .idempotency_token = "IdempotencyToken",
    };
};

pub const UpdateFrameworkOutput = struct {
    /// The date and time that a framework is created, in ISO 8601 representation.
    /// The value of `CreationTime` is accurate to milliseconds. For example,
    /// 2020-07-10T15:00:00.000-08:00 represents the 10th of July 2020 at 3:00 PM 8
    /// hours behind
    /// UTC.
    creation_time: ?i64 = null,

    /// An Amazon Resource Name (ARN) that uniquely identifies a resource. The
    /// format of the ARN
    /// depends on the resource type.
    framework_arn: ?[]const u8 = null,

    /// The unique name of a framework. This name is between 1 and 256 characters,
    /// starting with
    /// a letter, and consisting of letters (a-z, A-Z), numbers (0-9), and
    /// underscores (_).
    framework_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .creation_time = "CreationTime",
        .framework_arn = "FrameworkArn",
        .framework_name = "FrameworkName",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateFrameworkInput, options: CallOptions) !UpdateFrameworkOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "backup", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateFrameworkInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("backup", "Backup", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/audit/frameworks/");
    try path_buf.appendSlice(allocator, input.framework_name);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.framework_controls) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"FrameworkControls\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.framework_description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"FrameworkDescription\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.idempotency_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"IdempotencyToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateFrameworkOutput {
    var result: UpdateFrameworkOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateFrameworkOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
