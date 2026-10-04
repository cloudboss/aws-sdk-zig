const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const BrowserSigningConfigInput = @import("browser_signing_config_input.zig").BrowserSigningConfigInput;
const Certificate = @import("certificate.zig").Certificate;
const BrowserEnterprisePolicy = @import("browser_enterprise_policy.zig").BrowserEnterprisePolicy;
const ToolsFileSystemConfiguration = @import("tools_file_system_configuration.zig").ToolsFileSystemConfiguration;
const BrowserNetworkConfiguration = @import("browser_network_configuration.zig").BrowserNetworkConfiguration;
const RecordingConfig = @import("recording_config.zig").RecordingConfig;
const BrowserStatus = @import("browser_status.zig").BrowserStatus;

pub const CreateBrowserInput = struct {
    /// The browser signing configuration that enables cryptographic agent
    /// identification using HTTP message signatures for web bot authentication.
    browser_signing: ?BrowserSigningConfigInput = null,

    /// A list of certificates to install in the browser.
    certificates: ?[]const Certificate = null,

    /// A unique, case-sensitive identifier to ensure that the operation completes
    /// no more than one time. If this token matches a previous request, Amazon
    /// Bedrock AgentCore ignores the request but does not return an error.
    client_token: ?[]const u8 = null,

    /// The description of the browser.
    description: ?[]const u8 = null,

    /// A list of enterprise policy files for the browser.
    enterprise_policies: ?[]const BrowserEnterprisePolicy = null,

    /// The Amazon Resource Name (ARN) of the IAM role that provides permissions for
    /// the browser to access Amazon Web Services services.
    execution_role_arn: ?[]const u8 = null,

    /// The file system configurations to mount into the browser. Use these
    /// configurations to mount your own Amazon Simple Storage Service (Amazon S3)
    /// Files or Amazon Elastic File System (Amazon EFS) access points. Your
    /// sessions can then access your data. If you don't specify this field, no file
    /// systems are mounted.
    filesystem_configurations: ?[]const ToolsFileSystemConfiguration = null,

    /// The name of the browser. The name must be unique within your account.
    name: []const u8,

    /// The network configuration for the browser. This configuration specifies the
    /// network mode for the browser.
    network_configuration: BrowserNetworkConfiguration,

    /// The recording configuration for the browser. When enabled, browser sessions
    /// are recorded and stored in the specified Amazon S3 location.
    recording: ?RecordingConfig = null,

    /// A map of tag keys and values to assign to the browser. Tags enable you to
    /// categorize your resources in different ways, for example, by purpose, owner,
    /// or environment.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .browser_signing = "browserSigning",
        .certificates = "certificates",
        .client_token = "clientToken",
        .description = "description",
        .enterprise_policies = "enterprisePolicies",
        .execution_role_arn = "executionRoleArn",
        .filesystem_configurations = "filesystemConfigurations",
        .name = "name",
        .network_configuration = "networkConfiguration",
        .recording = "recording",
        .tags = "tags",
    };
};

pub const CreateBrowserOutput = struct {
    /// The Amazon Resource Name (ARN) of the created browser.
    browser_arn: []const u8,

    /// The unique identifier of the created browser.
    browser_id: []const u8,

    /// The timestamp when the browser was created.
    created_at: i64,

    /// The current status of the browser.
    status: BrowserStatus,

    pub const json_field_names = .{
        .browser_arn = "browserArn",
        .browser_id = "browserId",
        .created_at = "createdAt",
        .status = "status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateBrowserInput, options: CallOptions) !CreateBrowserOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "bedrock-agentcore", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateBrowserInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock-agentcore-control", "Bedrock AgentCore Control", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/browsers";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.browser_signing) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"browserSigning\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.certificates) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"certificates\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.enterprise_policies) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"enterprisePolicies\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.execution_role_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"executionRoleArn\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.filesystem_configurations) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"filesystemConfigurations\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"networkConfiguration\":");
    try aws.json.writeValue(@TypeOf(input.network_configuration), input.network_configuration, allocator, &body_buf);
    has_prev = true;
    if (input.recording) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"recording\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateBrowserOutput {
    const result: CreateBrowserOutput = try aws.json.parseJsonObject(
        CreateBrowserOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
