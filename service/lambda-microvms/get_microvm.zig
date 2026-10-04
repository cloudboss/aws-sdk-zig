const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const IdlePolicy = @import("idle_policy.zig").IdlePolicy;
const MicrovmState = @import("microvm_state.zig").MicrovmState;

pub const GetMicrovmInput = struct {
    /// The ID of the MicroVM to retrieve.
    microvm_identifier: []const u8,

    pub const json_field_names = .{
        .microvm_identifier = "microvmIdentifier",
    };
};

pub const GetMicrovmOutput = struct {
    /// The list of egress network connectors configured for the MicroVM.
    egress_network_connectors: ?[]const []const u8 = null,

    /// The HTTPS endpoint URL for communicating with the MicroVM. Include a valid
    /// authentication token in the X-aws-proxy-auth header when sending requests.
    endpoint: []const u8,

    /// The ARN of the IAM execution role assumed by the MicroVM.
    execution_role_arn: ?[]const u8 = null,

    /// The idle policy configuration of the MicroVM, controlling auto-suspend and
    /// auto-resume behavior.
    idle_policy: ?IdlePolicy = null,

    /// The ARN of the MicroVM image used to run this MicroVM.
    image_arn: []const u8,

    /// The version of the MicroVM image used to run this MicroVM.
    image_version: []const u8,

    /// The list of ingress network connectors configured for the MicroVM.
    ingress_network_connectors: ?[]const []const u8 = null,

    /// The maximum duration in seconds that the MicroVM can exist before being
    /// terminated by the platform.
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetMicrovmInput, options: CallOptions) !GetMicrovmOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetMicrovmInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("lambda", "Lambda Microvms", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/2025-09-09/microvms/");
    try path_buf.appendSlice(allocator, input.microvm_identifier);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetMicrovmOutput {
    const result: GetMicrovmOutput = try aws.json.parseJsonObject(
        GetMicrovmOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
