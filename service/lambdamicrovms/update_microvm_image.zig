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
const MicrovmImageState = @import("microvm_image_state.zig").MicrovmImageState;

pub const UpdateMicrovmImageInput = struct {
    /// Additional OS capabilities granted to the MicroVM runtime environment.
    additional_os_capabilities: ?[]const Capability = null,

    /// The ARN of the base MicroVM image.
    base_image_arn: []const u8,

    /// The specific version of the base MicroVM image to use.
    base_image_version: ?[]const u8 = null,

    /// The ARN of the IAM build role.
    build_role_arn: []const u8,

    /// A unique, case-sensitive identifier you provide to ensure the idempotency of
    /// the request.
    client_token: ?[]const u8 = null,

    /// The code artifact containing the application code and metadata for the
    /// MicroVM image.
    code_artifact: CodeArtifact,

    /// The list of supported CPU configurations for the MicroVM.
    cpu_configurations: ?[]const CpuConfiguration = null,

    /// The description of the MicroVM image.
    description: ?[]const u8 = null,

    /// The list of egress network connectors available to the MicroVM at runtime.
    egress_network_connectors: ?[]const []const u8 = null,

    /// Environment variables set in the MicroVM runtime environment.
    environment_variables: ?[]const aws.map.StringMapEntry = null,

    hooks: ?Hooks = null,

    /// The unique identifier (ARN or ID) of the MicroVM image to update.
    image_identifier: []const u8,

    /// The logging configuration for build-time and runtime logs. Specify
    /// {"cloudWatch": {"logGroup": "..."}} to stream logs to a custom CloudWatch
    /// log group, or {"disabled": {}} to turn off logging.
    logging: ?Logging = null,

    /// The resource requirements for the MicroVM.
    resources: ?[]const Resources = null,

    pub const json_field_names = .{
        .additional_os_capabilities = "additionalOsCapabilities",
        .base_image_arn = "baseImageArn",
        .base_image_version = "baseImageVersion",
        .build_role_arn = "buildRoleArn",
        .client_token = "clientToken",
        .code_artifact = "codeArtifact",
        .cpu_configurations = "cpuConfigurations",
        .description = "description",
        .egress_network_connectors = "egressNetworkConnectors",
        .environment_variables = "environmentVariables",
        .hooks = "hooks",
        .image_identifier = "imageIdentifier",
        .logging = "logging",
        .resources = "resources",
    };
};

pub const UpdateMicrovmImageOutput = struct {
    /// Additional OS capabilities granted to the MicroVM runtime environment.
    additional_os_capabilities: ?[]const Capability = null,

    /// The ARN of the base MicroVM image.
    base_image_arn: []const u8,

    /// The specific version of the base MicroVM image.
    base_image_version: ?[]const u8 = null,

    /// The ARN of the IAM build role.
    build_role_arn: []const u8,

    /// The code artifact containing the application code and metadata for the
    /// MicroVM image.
    code_artifact: ?CodeArtifact = null,

    /// The list of supported CPU configurations for the MicroVM.
    cpu_configurations: ?[]const CpuConfiguration = null,

    /// The timestamp when the MicroVM image was created.
    created_at: i64,

    /// The description of the MicroVM image.
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

    /// The latest active version of the MicroVM image.
    latest_active_image_version: ?[]const u8 = null,

    /// The latest failed version of the MicroVM image, if any.
    latest_failed_image_version: ?[]const u8 = null,

    /// The logging configuration for build-time and runtime logs. Specify
    /// {"cloudWatch": {"logGroup": "..."}} to stream logs to a custom CloudWatch
    /// log group, or {"disabled": {}} to turn off logging.
    logging: ?Logging = null,

    /// The name of the MicroVM image.
    name: []const u8,

    /// The resource requirements for the MicroVM.
    resources: ?[]const Resources = null,

    /// The current state of the MicroVM image.
    state: MicrovmImageState,

    /// The timestamp when the MicroVM image was last updated.
    updated_at: i64,

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
        .latest_active_image_version = "latestActiveImageVersion",
        .latest_failed_image_version = "latestFailedImageVersion",
        .logging = "logging",
        .name = "name",
        .resources = "resources",
        .state = "state",
        .updated_at = "updatedAt",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateMicrovmImageInput, options: CallOptions) !UpdateMicrovmImageOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateMicrovmImageInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("lambda", "Lambda Microvms", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/2025-09-09/microvm-images/");
    try path_buf.appendSlice(allocator, input.image_identifier);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.additional_os_capabilities) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"additionalOsCapabilities\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"baseImageArn\":");
    try aws.json.writeValue(@TypeOf(input.base_image_arn), input.base_image_arn, allocator, &body_buf);
    has_prev = true;
    if (input.base_image_version) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"baseImageVersion\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"buildRoleArn\":");
    try aws.json.writeValue(@TypeOf(input.build_role_arn), input.build_role_arn, allocator, &body_buf);
    has_prev = true;
    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"codeArtifact\":");
    try aws.json.writeValue(@TypeOf(input.code_artifact), input.code_artifact, allocator, &body_buf);
    has_prev = true;
    if (input.cpu_configurations) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"cpuConfigurations\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.egress_network_connectors) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"egressNetworkConnectors\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.environment_variables) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"environmentVariables\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.hooks) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"hooks\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.logging) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"logging\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.resources) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"resources\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateMicrovmImageOutput {
    const result: UpdateMicrovmImageOutput = try aws.json.parseJsonObject(
        UpdateMicrovmImageOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
