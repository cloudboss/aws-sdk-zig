const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const StartAutomationJobInput = struct {
    /// The ID of the automation group that contains the automation to run.
    automation_group_id: []const u8,

    /// The ID of the automation to run.
    automation_id: []const u8,

    /// The ID of the Amazon Web Services account that contains the automation.
    aws_account_id: []const u8,

    /// The input payload for the automation job, provided as a JSON string.
    input_payload: ?[]const u8 = null,

    pub const json_field_names = .{
        .automation_group_id = "AutomationGroupId",
        .automation_id = "AutomationId",
        .aws_account_id = "AwsAccountId",
        .input_payload = "InputPayload",
    };
};

pub const StartAutomationJobOutput = struct {
    /// The Amazon Resource Name (ARN) of the automation job.
    arn: []const u8,

    /// The ID of the automation job that was started.
    job_id: []const u8,

    /// The Amazon Web Services request ID for this operation.
    request_id: ?[]const u8 = null,

    /// The HTTP status of the request.
    status: ?i32 = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .job_id = "JobId",
        .request_id = "RequestId",
        .status = "Status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartAutomationJobInput, options: CallOptions) !StartAutomationJobOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "quicksight", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: StartAutomationJobInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("quicksight", "QuickSight", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/accounts/");
    try path_buf.appendSlice(allocator, input.aws_account_id);
    try path_buf.appendSlice(allocator, "/automation-groups/");
    try path_buf.appendSlice(allocator, input.automation_group_id);
    try path_buf.appendSlice(allocator, "/automations/");
    try path_buf.appendSlice(allocator, input.automation_id);
    try path_buf.appendSlice(allocator, "/jobs");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.input_payload) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"InputPayload\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartAutomationJobOutput {
    var result: StartAutomationJobOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(StartAutomationJobOutput, body, allocator);
    }
    result.status = @intCast(status);
    _ = headers;

    return result;
}
