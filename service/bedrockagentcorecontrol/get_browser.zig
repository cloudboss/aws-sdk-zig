const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const BrowserSigningConfigOutput = @import("browser_signing_config_output.zig").BrowserSigningConfigOutput;
const Certificate = @import("certificate.zig").Certificate;
const BrowserEnterprisePolicy = @import("browser_enterprise_policy.zig").BrowserEnterprisePolicy;
const ToolsFileSystemConfiguration = @import("tools_file_system_configuration.zig").ToolsFileSystemConfiguration;
const BrowserNetworkConfiguration = @import("browser_network_configuration.zig").BrowserNetworkConfiguration;
const RecordingConfig = @import("recording_config.zig").RecordingConfig;
const BrowserStatus = @import("browser_status.zig").BrowserStatus;

pub const GetBrowserInput = struct {
    /// The unique identifier of the browser to retrieve.
    browser_id: []const u8,

    pub const json_field_names = .{
        .browser_id = "browserId",
    };
};

pub const GetBrowserOutput = struct {
    /// The Amazon Resource Name (ARN) of the browser.
    browser_arn: []const u8,

    /// The unique identifier of the browser.
    browser_id: []const u8,

    /// The browser signing configuration that shows whether cryptographic agent
    /// identification is enabled for web bot authentication.
    browser_signing: ?BrowserSigningConfigOutput = null,

    /// The list of certificates configured for the browser.
    certificates: ?[]const Certificate = null,

    /// The timestamp when the browser was created.
    created_at: i64,

    /// The description of the browser.
    description: ?[]const u8 = null,

    /// The list of enterprise policy files configured for the browser.
    enterprise_policies: ?[]const BrowserEnterprisePolicy = null,

    /// The IAM role ARN that provides permissions for the browser.
    execution_role_arn: ?[]const u8 = null,

    /// The reason for failure if the browser is in a failed state.
    failure_reason: ?[]const u8 = null,

    /// The file system configurations mounted into the browser. Each entry
    /// describes an access point and its mount path.
    filesystem_configurations: ?[]const ToolsFileSystemConfiguration = null,

    /// The timestamp when the browser was last updated.
    last_updated_at: i64,

    /// The name of the browser.
    name: []const u8,

    network_configuration: ?BrowserNetworkConfiguration = null,

    recording: ?RecordingConfig = null,

    /// The current status of the browser.
    status: BrowserStatus,

    pub const json_field_names = .{
        .browser_arn = "browserArn",
        .browser_id = "browserId",
        .browser_signing = "browserSigning",
        .certificates = "certificates",
        .created_at = "createdAt",
        .description = "description",
        .enterprise_policies = "enterprisePolicies",
        .execution_role_arn = "executionRoleArn",
        .failure_reason = "failureReason",
        .filesystem_configurations = "filesystemConfigurations",
        .last_updated_at = "lastUpdatedAt",
        .name = "name",
        .network_configuration = "networkConfiguration",
        .recording = "recording",
        .status = "status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetBrowserInput, options: CallOptions) !GetBrowserOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetBrowserInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock-agentcore-control", "Bedrock AgentCore Control", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/browsers/");
    try path_buf.appendSlice(allocator, input.browser_id);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetBrowserOutput {
    const result: GetBrowserOutput = try aws.json.parseJsonObject(
        GetBrowserOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
