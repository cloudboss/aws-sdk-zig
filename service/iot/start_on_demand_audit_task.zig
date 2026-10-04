const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const StartOnDemandAuditTaskInput = struct {
    /// Which checks are performed during the audit. The checks you specify must be
    /// enabled
    /// for your account or an exception occurs. Use
    /// `DescribeAccountAuditConfiguration`
    /// to see the list of all checks, including those that are enabled or
    /// `UpdateAccountAuditConfiguration` to select which checks are enabled.
    target_check_names: []const []const u8,

    pub const json_field_names = .{
        .target_check_names = "targetCheckNames",
    };
};

pub const StartOnDemandAuditTaskOutput = struct {
    /// The ID of the on-demand audit you started.
    task_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .task_id = "taskId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartOnDemandAuditTaskInput, options: CallOptions) !StartOnDemandAuditTaskOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "iot", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: StartOnDemandAuditTaskInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iot", "IoT", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/audit/tasks";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"targetCheckNames\":");
    try aws.json.writeValue(@TypeOf(input.target_check_names), input.target_check_names, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartOnDemandAuditTaskOutput {
    var result: StartOnDemandAuditTaskOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(StartOnDemandAuditTaskOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
