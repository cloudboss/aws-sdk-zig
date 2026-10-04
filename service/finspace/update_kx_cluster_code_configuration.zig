const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CodeConfiguration = @import("code_configuration.zig").CodeConfiguration;
const KxCommandLineArgument = @import("kx_command_line_argument.zig").KxCommandLineArgument;
const KxClusterCodeDeploymentConfiguration = @import("kx_cluster_code_deployment_configuration.zig").KxClusterCodeDeploymentConfiguration;

pub const UpdateKxClusterCodeConfigurationInput = struct {
    /// A token that ensures idempotency. This token expires in 10 minutes.
    client_token: ?[]const u8 = null,

    /// The name of the cluster.
    cluster_name: []const u8,

    code: CodeConfiguration,

    /// Specifies the key-value pairs to make them available inside the cluster.
    ///
    /// You cannot update this parameter for a `NO_RESTART` deployment.
    command_line_arguments: ?[]const KxCommandLineArgument = null,

    /// The configuration that allows you to choose how you want to update the code
    /// on a cluster.
    deployment_configuration: ?KxClusterCodeDeploymentConfiguration = null,

    /// A unique identifier of the kdb environment.
    environment_id: []const u8,

    /// Specifies a Q program that will be run at launch of a cluster. It is a
    /// relative path within
    /// *.zip* file that contains the custom code, which will be loaded on
    /// the cluster. It must include the file name itself. For example,
    /// `somedir/init.q`.
    ///
    /// You cannot update this parameter for a `NO_RESTART` deployment.
    initialization_script: ?[]const u8 = null,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .cluster_name = "clusterName",
        .code = "code",
        .command_line_arguments = "commandLineArguments",
        .deployment_configuration = "deploymentConfiguration",
        .environment_id = "environmentId",
        .initialization_script = "initializationScript",
    };
};

pub const UpdateKxClusterCodeConfigurationOutput = struct {
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateKxClusterCodeConfigurationInput, options: CallOptions) !UpdateKxClusterCodeConfigurationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "finspace", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateKxClusterCodeConfigurationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("finspace", "finspace", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/kx/environments/");
    try path_buf.appendSlice(allocator, input.environment_id);
    try path_buf.appendSlice(allocator, "/clusters/");
    try path_buf.appendSlice(allocator, input.cluster_name);
    try path_buf.appendSlice(allocator, "/configuration/code");
    const path = try path_buf.toOwnedSlice(allocator);

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
    try body_buf.appendSlice(allocator, "\"code\":");
    try aws.json.writeValue(@TypeOf(input.code), input.code, allocator, &body_buf);
    has_prev = true;
    if (input.command_line_arguments) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"commandLineArguments\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.deployment_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"deploymentConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.initialization_script) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"initializationScript\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateKxClusterCodeConfigurationOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: UpdateKxClusterCodeConfigurationOutput = .{};

    return result;
}
