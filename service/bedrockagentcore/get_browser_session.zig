const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Certificate = @import("certificate.zig").Certificate;
const BrowserEnterprisePolicy = @import("browser_enterprise_policy.zig").BrowserEnterprisePolicy;
const BrowserExtension = @import("browser_extension.zig").BrowserExtension;
const ToolsFileSystemConfiguration = @import("tools_file_system_configuration.zig").ToolsFileSystemConfiguration;
const BrowserProfileConfiguration = @import("browser_profile_configuration.zig").BrowserProfileConfiguration;
const ProxyConfiguration = @import("proxy_configuration.zig").ProxyConfiguration;
const BrowserSessionStatus = @import("browser_session_status.zig").BrowserSessionStatus;
const BrowserSessionStream = @import("browser_session_stream.zig").BrowserSessionStream;
const ViewPort = @import("view_port.zig").ViewPort;

pub const GetBrowserSessionInput = struct {
    /// The unique identifier of the browser associated with the session.
    browser_identifier: []const u8,

    /// The unique identifier of the browser session to retrieve.
    session_id: []const u8,

    pub const json_field_names = .{
        .browser_identifier = "browserIdentifier",
        .session_id = "sessionId",
    };
};

pub const GetBrowserSessionOutput = struct {
    /// The identifier of the browser.
    browser_identifier: []const u8,

    /// The list of certificates installed in the browser session.
    certificates: ?[]const Certificate = null,

    /// The time at which the browser session was created.
    created_at: i64,

    /// A list of files containing enterprise policies for the browser session.
    enterprise_policies: ?[]const BrowserEnterprisePolicy = null,

    /// The list of browser extensions that are configured in the browser session.
    extensions: ?[]const BrowserExtension = null,

    /// The file system configurations for the browser session. Each entry describes
    /// an access point and its mount path.
    filesystem_configurations: ?[]const ToolsFileSystemConfiguration = null,

    /// The time at which the browser session was last updated.
    last_updated_at: ?i64 = null,

    /// The name of the browser session.
    name: ?[]const u8 = null,

    /// The browser profile configuration associated with this session. Contains the
    /// profile identifier that links to persistent browser data such as cookies and
    /// local storage.
    profile_configuration: ?BrowserProfileConfiguration = null,

    /// The active proxy configuration for this browser session. This field is only
    /// present if proxy configuration was provided when the session was started
    /// using `StartBrowserSession`. The configuration includes proxy servers,
    /// domain bypass rules and the proxy authentication credentials.
    proxy_configuration: ?ProxyConfiguration = null,

    /// The identifier of the browser session.
    session_id: []const u8,

    /// The artifact containing the session replay information.
    session_replay_artifact: ?[]const u8 = null,

    /// The timeout period for the browser session in seconds.
    session_timeout_seconds: ?i32 = null,

    /// The current status of the browser session. Possible values include ACTIVE,
    /// STOPPING, and STOPPED.
    status: ?BrowserSessionStatus = null,

    /// The streams associated with this browser session. These include the
    /// automation stream and live view stream.
    streams: ?BrowserSessionStream = null,

    view_port: ?ViewPort = null,

    pub const json_field_names = .{
        .browser_identifier = "browserIdentifier",
        .certificates = "certificates",
        .created_at = "createdAt",
        .enterprise_policies = "enterprisePolicies",
        .extensions = "extensions",
        .filesystem_configurations = "filesystemConfigurations",
        .last_updated_at = "lastUpdatedAt",
        .name = "name",
        .profile_configuration = "profileConfiguration",
        .proxy_configuration = "proxyConfiguration",
        .session_id = "sessionId",
        .session_replay_artifact = "sessionReplayArtifact",
        .session_timeout_seconds = "sessionTimeoutSeconds",
        .status = "status",
        .streams = "streams",
        .view_port = "viewPort",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetBrowserSessionInput, options: CallOptions) !GetBrowserSessionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetBrowserSessionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock-agentcore", "Bedrock AgentCore", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/browsers/");
    try path_buf.appendSlice(allocator, input.browser_identifier);
    try path_buf.appendSlice(allocator, "/sessions/get");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "sessionId=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.session_id);
    query_has_prev = true;
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetBrowserSessionOutput {
    const result: GetBrowserSessionOutput = try aws.json.parseJsonObject(
        GetBrowserSessionOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
