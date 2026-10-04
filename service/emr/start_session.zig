const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Configuration = @import("configuration.zig").Configuration;
const SessionMonitoringConfiguration = @import("session_monitoring_configuration.zig").SessionMonitoringConfiguration;
const Tag = @import("tag.zig").Tag;
const SessionState = @import("session_state.zig").SessionState;

pub const StartSessionInput = struct {
    /// A unique, case-sensitive identifier that you provide to ensure the
    /// idempotency of the request. If you retry a request that completed
    /// successfully using the same client request token, the service returns the
    /// original response without performing the operation again.
    client_request_token: ?[]const u8 = null,

    /// The ID of the cluster on which to start the session.
    cluster_id: []const u8,

    /// The configuration overrides for the session. Only runtime configuration
    /// overrides are supported.
    engine_configurations: ?[]const Configuration = null,

    /// The execution role ARN for the session. Amazon EMR uses this role to access
    /// Amazon Web Services resources on your behalf during session execution.
    execution_role_arn: ?[]const u8 = null,

    /// The monitoring configuration that controls where session logs are published,
    /// such as Amazon S3, CloudWatch, or managed logging.
    monitoring_configuration: ?SessionMonitoringConfiguration = null,

    /// An optional name for the session.
    name: ?[]const u8 = null,

    /// The idle timeout, in minutes. If the session is idle for this duration,
    /// Amazon EMR EC2 automatically terminates it.
    session_idle_timeout_in_minutes: ?i64 = null,

    /// The tags to assign to the session.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .client_request_token = "ClientRequestToken",
        .cluster_id = "ClusterId",
        .engine_configurations = "EngineConfigurations",
        .execution_role_arn = "ExecutionRoleArn",
        .monitoring_configuration = "MonitoringConfiguration",
        .name = "Name",
        .session_idle_timeout_in_minutes = "SessionIdleTimeoutInMinutes",
        .tags = "Tags",
    };
};

pub const StartSessionOutput = struct {
    /// The Amazon Web Services account ID that owns the session.
    account_id: ?[]const u8 = null,

    /// The output contains the ARN of the session.
    arn: ?[]const u8 = null,

    /// The ID of the cluster that the session was started on.
    cluster_id: ?[]const u8 = null,

    /// The output contains the ID of the session.
    id: []const u8,

    /// The state of the session at the time the request returned. When a session is
    /// first created, it enters the `SUBMITTED` state.
    state: ?SessionState = null,

    pub const json_field_names = .{
        .account_id = "AccountId",
        .arn = "Arn",
        .cluster_id = "ClusterId",
        .id = "Id",
        .state = "State",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartSessionInput, options: CallOptions) !StartSessionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "elasticmapreduce", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: StartSessionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("elasticmapreduce", "EMR", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "ElasticMapReduce.StartSession");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartSessionOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(StartSessionOutput, body, allocator);
}
