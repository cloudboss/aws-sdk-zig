const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Capability = @import("capability.zig").Capability;
const CodeArtifact = @import("code_artifact.zig").CodeArtifact;
const CpuConfiguration = @import("cpu_configuration.zig").CpuConfiguration;
const Hooks = @import("hooks.zig").Hooks;
const Logging = @import("logging.zig").Logging;
const Resources = @import("resources.zig").Resources;
const MicrovmImageVersionState = @import("microvm_image_version_state.zig").MicrovmImageVersionState;
const MicrovmImageVersionStatus = @import("microvm_image_version_status.zig").MicrovmImageVersionStatus;

pub const GetMicrovmImageVersionInput = struct {
    /// The unique identifier (ARN or ID) of the MicroVM image.
    image_identifier: []const u8,

    /// The version of the MicroVM image to retrieve.
    image_version: []const u8,

    pub const json_field_names = .{
        .image_identifier = "imageIdentifier",
        .image_version = "imageVersion",
    };
};

pub const GetMicrovmImageVersionOutput = struct {
    /// Additional OS capabilities granted to the MicroVM runtime environment.
    additional_os_capabilities: ?[]const Capability = null,

    /// The ARN of the base MicroVM image used.
    base_image_arn: []const u8,

    /// The specific version of the base MicroVM image.
    base_image_version: ?[]const u8 = null,

    /// The ARN of the IAM build role.
    build_role_arn: []const u8,

    /// The code artifact for this version.
    code_artifact: ?CodeArtifact = null,

    /// The list of supported CPU configurations for the MicroVM.
    cpu_configurations: ?[]const CpuConfiguration = null,

    /// The timestamp when the version was created.
    created_at: i64,

    /// The description of the version.
    description: ?[]const u8 = null,

    /// The list of egress network connectors available to the MicroVM at runtime.
    egress_network_connectors: ?[]const []const u8 = null,

    /// Environment variables set in the MicroVM runtime environment.
    environment_variables: ?[]const aws.map.StringMapEntry = null,

    hooks: ?Hooks = null,

    /// The ARN of the MicroVM image.
    image_arn: []const u8,

    /// The version of the MicroVM image.
    image_version: []const u8,

    /// The logging configuration for this version.
    logging: ?Logging = null,

    /// The resource requirements for the MicroVM.
    resources: ?[]const Resources = null,

    /// The current state of the version.
    state: MicrovmImageVersionState,

    /// The reason for the current state. For example, one or more builds failed.
    state_reason: ?[]const u8 = null,

    /// The availability status of the version: ACTIVE (can be used by RunMicrovm)
    /// or INACTIVE (blocked from launching new MicroVMs).
    status: MicrovmImageVersionStatus,

    /// Key-value pairs associated with the version.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The timestamp when the version was last updated.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .additional_os_capabilities = "additionalOsCapabilities",
        .base_image_arn = "baseImageArn",
        .base_image_version = "baseImageVersion",
        .build_role_arn = "buildRoleArn",
        .code_artifact = "codeArtifact",
        .cpu_configurations = "cpuConfigurations",
        .created_at = "createdAt",
        .description = "description",
        .egress_network_connectors = "egressNetworkConnectors",
        .environment_variables = "environmentVariables",
        .hooks = "hooks",
        .image_arn = "imageArn",
        .image_version = "imageVersion",
        .logging = "logging",
        .resources = "resources",
        .state = "state",
        .state_reason = "stateReason",
        .status = "status",
        .tags = "tags",
        .updated_at = "updatedAt",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetMicrovmImageVersionInput, options: CallOptions) !GetMicrovmImageVersionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetMicrovmImageVersionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("lambda", "Lambda Microvms", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/2025-09-09/microvm-images/");
    try path_buf.appendSlice(allocator, input.image_identifier);
    try path_buf.appendSlice(allocator, "/versions/");
    try path_buf.appendSlice(allocator, input.image_version);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetMicrovmImageVersionOutput {
    const result: GetMicrovmImageVersionOutput = try aws.json.parseJsonObject(
        GetMicrovmImageVersionOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
