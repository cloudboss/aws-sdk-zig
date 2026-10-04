const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const FlowStatus = @import("flow_status.zig").FlowStatus;

pub const StartFlowInput = struct {
    /// The `clientToken` parameter is an idempotency token. It ensures that your
    /// `StartFlow` request completes only once. You choose the value to pass. For
    /// example, if you don't receive a response from your request, you can safely
    /// retry the request
    /// with the same `clientToken` parameter value.
    ///
    /// If you omit a `clientToken` value, the Amazon Web Services SDK that you are
    /// using inserts a value for you. This way, the SDK can safely retry requests
    /// multiple times
    /// after a network error. You must provide your own value for other use cases.
    ///
    /// If you specify input parameters that differ from your first request, an
    /// error occurs for
    /// flows that run on a schedule or based on an event. However, the error
    /// doesn't occur for flows
    /// that run on demand. You set the conditions that initiate your flow for the
    /// `triggerConfig` parameter.
    ///
    /// If you use a different value for `clientToken`, Amazon AppFlow considers
    /// it a new call to `StartFlow`. The token is active for 8 hours.
    client_token: ?[]const u8 = null,

    /// The specified name of the flow. Spaces are not allowed. Use underscores (_)
    /// or hyphens
    /// (-) only.
    flow_name: []const u8,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .flow_name = "flowName",
    };
};

pub const StartFlowOutput = struct {
    /// Returns the internal execution ID of an on-demand flow when the flow is
    /// started. For
    /// scheduled or event-triggered flows, this value is null.
    execution_id: ?[]const u8 = null,

    /// The flow's Amazon Resource Name (ARN).
    flow_arn: ?[]const u8 = null,

    /// Indicates the current status of the flow.
    flow_status: ?FlowStatus = null,

    pub const json_field_names = .{
        .execution_id = "executionId",
        .flow_arn = "flowArn",
        .flow_status = "flowStatus",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartFlowInput, options: CallOptions) !StartFlowOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "appflow", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: StartFlowInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("appflow", "Appflow", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/start-flow";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"flowName\":");
    try aws.json.writeValue(@TypeOf(input.flow_name), input.flow_name, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartFlowOutput {
    var result: StartFlowOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(StartFlowOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
