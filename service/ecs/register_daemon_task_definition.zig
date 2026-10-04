const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DaemonContainerDefinition = @import("daemon_container_definition.zig").DaemonContainerDefinition;
const DaemonIpcMode = @import("daemon_ipc_mode.zig").DaemonIpcMode;
const DaemonPidMode = @import("daemon_pid_mode.zig").DaemonPidMode;
const Tag = @import("tag.zig").Tag;
const DaemonVolume = @import("daemon_volume.zig").DaemonVolume;

pub const RegisterDaemonTaskDefinitionInput = struct {
    /// A list of container definitions in JSON format that describe the containers
    /// that make up your daemon task.
    container_definitions: []const DaemonContainerDefinition,

    /// The number of CPU units used by the daemon task. It can be expressed as an
    /// integer using CPU units (for example, `1024`).
    cpu: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the task execution role that grants the
    /// Amazon ECS container agent permission to make Amazon Web Services API calls
    /// on your behalf. The task execution role is required for daemon tasks that
    /// pull container images from Amazon ECR or send container logs to CloudWatch.
    execution_role_arn: ?[]const u8 = null,

    /// You must specify a `family` for a daemon task definition. This family is
    /// used as a name for your daemon task definition. Up to 255 letters (uppercase
    /// and lowercase), numbers, underscores, and hyphens are allowed.
    family: []const u8,

    /// The IPC namespace mode for the daemon. The valid values are `none` and
    /// `shared`. The default is `none`.
    ///
    /// If `none` is specified or no value is provided, the daemon runs with its own
    /// IPC namespace, isolated from other tasks. If `shared` is specified, the
    /// daemon joins the host IPC namespace, making it accessible to non-daemon
    /// tasks that use `ipcMode: "host"` or other daemons that use `ipcMode:
    /// "shared"`.
    ipc_mode: ?DaemonIpcMode = null,

    /// The amount of memory (in MiB) used by the daemon task. It can be expressed
    /// as an integer using MiB (for example, `1024`).
    memory: ?[]const u8 = null,

    /// The PID namespace mode for the daemon. The valid values are `none` and
    /// `shared`. The default is `none`.
    ///
    /// If `none` is specified or no value is provided, the daemon runs with its own
    /// PID namespace, isolated from other tasks. If `shared` is specified, the
    /// daemon joins the host PID namespace, making it accessible to non-daemon
    /// tasks that use `pidMode: "host"` or other daemons that use `pidMode:
    /// "shared"`.
    pid_mode: ?DaemonPidMode = null,

    /// The metadata that you apply to the daemon task definition to help you
    /// categorize and organize them. Each tag consists of a key and an optional
    /// value. You define both of them.
    ///
    /// The following basic restrictions apply to tags:
    ///
    /// * Maximum number of tags per resource - 50
    /// * For each resource, each tag key must be unique, and each tag key can have
    ///   only one value.
    /// * Maximum key length - 128 Unicode characters in UTF-8
    /// * Maximum value length - 256 Unicode characters in UTF-8
    /// * If your tagging schema is used across multiple services and resources,
    ///   remember that other services may have restrictions on allowed characters.
    ///   Generally allowed characters are: letters, numbers, and spaces
    ///   representable in UTF-8, and the following characters: + - = . _ : / @.
    /// * Tag keys and values are case-sensitive.
    /// * Do not use `aws:`, `AWS:`, or any upper or lowercase combination of such
    ///   as a prefix for either keys or values as it is reserved for Amazon Web
    ///   Services use. You cannot edit or delete tag keys or values with this
    ///   prefix. Tags with this prefix do not count against your tags per resource
    ///   limit.
    tags: ?[]const Tag = null,

    /// The short name or full Amazon Resource Name (ARN) of the IAM role that
    /// containers in this daemon task can assume. All containers in this daemon
    /// task are granted the permissions that are specified in this role.
    task_role_arn: ?[]const u8 = null,

    /// A list of volume definitions in JSON format that containers in your daemon
    /// task can use.
    volumes: ?[]const DaemonVolume = null,

    pub const json_field_names = .{
        .container_definitions = "containerDefinitions",
        .cpu = "cpu",
        .execution_role_arn = "executionRoleArn",
        .family = "family",
        .ipc_mode = "ipcMode",
        .memory = "memory",
        .pid_mode = "pidMode",
        .tags = "tags",
        .task_role_arn = "taskRoleArn",
        .volumes = "volumes",
    };
};

pub const RegisterDaemonTaskDefinitionOutput = struct {
    /// The full Amazon Resource Name (ARN) of the registered daemon task
    /// definition.
    daemon_task_definition_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .daemon_task_definition_arn = "daemonTaskDefinitionArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: RegisterDaemonTaskDefinitionInput, options: CallOptions) !RegisterDaemonTaskDefinitionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ecs", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: RegisterDaemonTaskDefinitionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ecs", "ECS", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AmazonEC2ContainerServiceV20141113.RegisterDaemonTaskDefinition");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !RegisterDaemonTaskDefinitionOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(RegisterDaemonTaskDefinitionOutput, body, allocator);
}
