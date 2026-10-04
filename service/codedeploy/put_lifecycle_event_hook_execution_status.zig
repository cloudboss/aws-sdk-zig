const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const LifecycleEventStatus = @import("lifecycle_event_status.zig").LifecycleEventStatus;

pub const PutLifecycleEventHookExecutionStatusInput = struct {
    /// The unique ID of a deployment. Pass this ID to a Lambda function that
    /// validates a deployment lifecycle event.
    deployment_id: ?[]const u8 = null,

    /// The execution ID of a deployment's lifecycle hook. A deployment lifecycle
    /// hook is
    /// specified in the `hooks` section of the AppSpec file.
    lifecycle_event_hook_execution_id: ?[]const u8 = null,

    /// The result of a Lambda function that validates a deployment lifecycle
    /// event. The values listed in **Valid Values** are valid for
    /// lifecycle statuses in general; however, only `Succeeded` and
    /// `Failed` can be passed successfully in your API call.
    status: ?LifecycleEventStatus = null,

    pub const json_field_names = .{
        .deployment_id = "deploymentId",
        .lifecycle_event_hook_execution_id = "lifecycleEventHookExecutionId",
        .status = "status",
    };
};

pub const PutLifecycleEventHookExecutionStatusOutput = struct {
    /// The execution ID of the lifecycle event hook. A hook is specified in the
    /// `hooks` section of the deployment's AppSpec file.
    lifecycle_event_hook_execution_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .lifecycle_event_hook_execution_id = "lifecycleEventHookExecutionId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutLifecycleEventHookExecutionStatusInput, options: CallOptions) !PutLifecycleEventHookExecutionStatusOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "codedeploy", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: PutLifecycleEventHookExecutionStatusInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("codedeploy", "CodeDeploy", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "CodeDeploy_20141006.PutLifecycleEventHookExecutionStatus");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutLifecycleEventHookExecutionStatusOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(PutLifecycleEventHookExecutionStatusOutput, body, allocator);
}
