const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const EngineConfiguration = @import("engine_configuration.zig").EngineConfiguration;
const MonitoringConfiguration = @import("monitoring_configuration.zig").MonitoringConfiguration;
const Tag = @import("tag.zig").Tag;
const SessionState = @import("session_state.zig").SessionState;

pub const StartSessionInput = struct {
    /// A unique case-sensitive string used to ensure the request to create the
    /// session is
    /// idempotent (executes only once). If another `StartSessionRequest` is
    /// received, the same response is returned and another session is not created.
    /// If a
    /// parameter has changed, an error is returned.
    ///
    /// This token is listed as not required because Amazon Web Services SDKs (for
    /// example
    /// the Amazon Web Services SDK for Java) auto-generate the token for users. If
    /// you are
    /// not using the Amazon Web Services SDK or the Amazon Web Services CLI, you
    /// must provide
    /// this token or the action will fail.
    client_request_token: ?[]const u8 = null,

    /// Copies the tags from the Workgroup to the Session when.
    copy_work_group_tags: ?bool = null,

    /// The session description.
    description: ?[]const u8 = null,

    /// Contains engine data processing unit (DPU) configuration settings and
    /// parameter
    /// mappings.
    engine_configuration: EngineConfiguration,

    /// The ARN of the execution role used to access user resources for Spark
    /// sessions and
    /// Identity Center enabled workgroups. This property applies only to Spark
    /// enabled
    /// workgroups and Identity Center enabled workgroups.
    execution_role: ?[]const u8 = null,

    /// Contains the configuration settings for managed log persistence, delivering
    /// logs to Amazon S3 buckets,
    /// Amazon CloudWatch log groups etc.
    monitoring_configuration: ?MonitoringConfiguration = null,

    /// The notebook version. This value is supplied automatically for notebook
    /// sessions in
    /// the Athena console and is not required for programmatic session access. The
    /// only valid notebook version is `Athena notebook version 1`. If
    /// you specify a value for `NotebookVersion`, you must also specify a value for
    /// `NotebookId`. See EngineConfiguration$AdditionalConfigs.
    notebook_version: ?[]const u8 = null,

    /// The idle timeout in minutes for the session.
    session_idle_timeout_in_minutes: ?i32 = null,

    /// A list of comma separated tags to add to the session that is created.
    tags: ?[]const Tag = null,

    /// The workgroup to which the session belongs.
    work_group: []const u8,

    pub const json_field_names = .{
        .client_request_token = "ClientRequestToken",
        .copy_work_group_tags = "CopyWorkGroupTags",
        .description = "Description",
        .engine_configuration = "EngineConfiguration",
        .execution_role = "ExecutionRole",
        .monitoring_configuration = "MonitoringConfiguration",
        .notebook_version = "NotebookVersion",
        .session_idle_timeout_in_minutes = "SessionIdleTimeoutInMinutes",
        .tags = "Tags",
        .work_group = "WorkGroup",
    };
};

pub const StartSessionOutput = struct {
    /// The session ID.
    session_id: ?[]const u8 = null,

    /// The state of the session. A description of each state follows.
    ///
    /// `CREATING` - The session is being started, including acquiring
    /// resources.
    ///
    /// `CREATED` - The session has been started.
    ///
    /// `IDLE` - The session is able to accept a calculation.
    ///
    /// `BUSY` - The session is processing another task and is unable to accept a
    /// calculation.
    ///
    /// `TERMINATING` - The session is in the process of shutting down.
    ///
    /// `TERMINATED` - The session and its resources are no longer running.
    ///
    /// `DEGRADED` - The session has no healthy coordinators.
    ///
    /// `FAILED` - Due to a failure, the session and its resources are no longer
    /// running.
    state: ?SessionState = null,

    pub const json_field_names = .{
        .session_id = "SessionId",
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
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "athena", client.config.http_client.clock_skew_offset);

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
    const endpoint = try config.getEndpointForService("athena", "Athena", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AmazonAthena.StartSession");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartSessionOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(StartSessionOutput, body, allocator);
}
