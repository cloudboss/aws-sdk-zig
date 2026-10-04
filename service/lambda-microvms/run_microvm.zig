const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const IdlePolicy = @import("idle_policy.zig").IdlePolicy;
const Logging = @import("logging.zig").Logging;
const MicrovmState = @import("microvm_state.zig").MicrovmState;

pub const RunMicrovmInput = struct {
    /// A unique, case-sensitive identifier you provide to ensure the idempotency of
    /// the request.
    client_token: ?[]const u8 = null,

    /// The list of egress network connectors to configure for the MicroVM.
    egress_network_connectors: ?[]const []const u8 = null,

    /// The ARN of the IAM role to be assumed by the MicroVM during execution.
    execution_role_arn: ?[]const u8 = null,

    /// Configuration to control auto-suspend and auto-resume behavior.
    idle_policy: ?IdlePolicy = null,

    /// The identifier (ARN or ID) of the MicroVM image to run.
    image_identifier: []const u8,

    /// The version of the MicroVM image to run.
    image_version: ?[]const u8 = null,

    /// The list of ingress network connectors to configure for the MicroVM.
    ingress_network_connectors: ?[]const []const u8 = null,

    /// The logging configuration for this MicroVM instance. Specify {"cloudWatch":
    /// {"logGroup": "..."}} to stream application logs to a custom CloudWatch log
    /// group, or {"disabled": {}} to turn off logging.
    logging: ?Logging = null,

    /// The maximum duration in seconds that the MicroVM can exist before being
    /// terminated by the platform. Valid range: 1–28,800 (8 hours).
    maximum_duration_in_seconds: ?i32 = null,

    /// Per-MicroVM initialization data delivered as the request body of the /run
    /// lifecycle hook. Use to pass tenant-specific configuration such as session
    /// IDs or secret references. Maximum: 16,384 bytes.
    run_hook_payload: ?[]const u8 = null,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .egress_network_connectors = "egressNetworkConnectors",
        .execution_role_arn = "executionRoleArn",
        .idle_policy = "idlePolicy",
        .image_identifier = "imageIdentifier",
        .image_version = "imageVersion",
        .ingress_network_connectors = "ingressNetworkConnectors",
        .logging = "logging",
        .maximum_duration_in_seconds = "maximumDurationInSeconds",
        .run_hook_payload = "runHookPayload",
    };
};

pub const RunMicrovmOutput = struct {
    /// The list of egress network connectors configured for the MicroVM.
    egress_network_connectors: ?[]const []const u8 = null,

    /// The HTTPS endpoint URL for communicating with the MicroVM. Include a valid
    /// authentication token in the X-aws-proxy-auth header when sending requests.
    endpoint: []const u8,

    /// The ARN of the IAM execution role assumed by the MicroVM.
    execution_role_arn: ?[]const u8 = null,

    /// The idle policy configuration of the MicroVM.
    idle_policy: ?IdlePolicy = null,

    /// The ARN of the MicroVM image used to run this MicroVM.
    image_arn: []const u8,

    /// The version of the MicroVM image used to run this MicroVM.
    image_version: []const u8,

    /// The list of ingress network connectors configured for the MicroVM.
    ingress_network_connectors: ?[]const []const u8 = null,

    /// The maximum duration in seconds that the MicroVM can exist.
    maximum_duration_in_seconds: i32,

    /// The unique identifier of the MicroVM.
    microvm_id: []const u8,

    /// The timestamp when the MicroVM first started.
    started_at: i64,

    /// The current lifecycle state of the MicroVM.
    state: MicrovmState,

    /// The reason for why the MicroVM is in the current state.
    state_reason: ?[]const u8 = null,

    /// The timestamp when the MicroVM terminated.
    terminated_at: ?i64 = null,

    pub const json_field_names = .{
        .egress_network_connectors = "egressNetworkConnectors",
        .endpoint = "endpoint",
        .execution_role_arn = "executionRoleArn",
        .idle_policy = "idlePolicy",
        .image_arn = "imageArn",
        .image_version = "imageVersion",
        .ingress_network_connectors = "ingressNetworkConnectors",
        .maximum_duration_in_seconds = "maximumDurationInSeconds",
        .microvm_id = "microvmId",
        .started_at = "startedAt",
        .state = "state",
        .state_reason = "stateReason",
        .terminated_at = "terminatedAt",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: RunMicrovmInput, options: CallOptions) !RunMicrovmOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "lambda", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: RunMicrovmInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("lambda", "Lambda Microvms", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/2025-09-09/microvms";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.egress_network_connectors) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"egressNetworkConnectors\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.execution_role_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"executionRoleArn\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.idle_policy) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"idlePolicy\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"imageIdentifier\":");
    try aws.json.writeValue(@TypeOf(input.image_identifier), input.image_identifier, allocator, &body_buf);
    has_prev = true;
    if (input.image_version) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"imageVersion\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.ingress_network_connectors) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ingressNetworkConnectors\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.logging) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"logging\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.maximum_duration_in_seconds) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"maximumDurationInSeconds\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.run_hook_payload) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"runHookPayload\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !RunMicrovmOutput {
    const result: RunMicrovmOutput = try aws.json.parseJsonObject(
        RunMicrovmOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
