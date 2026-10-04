const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AccessEndpoint = @import("access_endpoint.zig").AccessEndpoint;
const AgentAccessConfig = @import("agent_access_config.zig").AgentAccessConfig;
const ApplicationSettings = @import("application_settings.zig").ApplicationSettings;
const ContentRedirection = @import("content_redirection.zig").ContentRedirection;
const StorageConnector = @import("storage_connector.zig").StorageConnector;
const StreamingExperienceSettings = @import("streaming_experience_settings.zig").StreamingExperienceSettings;
const UserSetting = @import("user_setting.zig").UserSetting;
const Stack = @import("stack.zig").Stack;

pub const CreateStackInput = struct {
    /// The list of interface VPC endpoint (interface endpoint) objects. Users of
    /// the stack can connect to WorkSpaces Applications only through the specified
    /// endpoints.
    access_endpoints: ?[]const AccessEndpoint = null,

    /// The configuration for agent access on the stack. If specified, agent access
    /// is enabled for the stack.
    agent_access_config: ?AgentAccessConfig = null,

    /// The persistent application settings for users of a stack. When these
    /// settings are enabled, changes that users make to applications and Windows
    /// settings are automatically saved after each session and applied to the next
    /// session.
    application_settings: ?ApplicationSettings = null,

    content_redirection: ?ContentRedirection = null,

    /// The description to display.
    description: ?[]const u8 = null,

    /// The stack name to display.
    display_name: ?[]const u8 = null,

    /// The domains where WorkSpaces Applications streaming sessions can be embedded
    /// in an iframe. You must approve the domains that you want to host embedded
    /// WorkSpaces Applications streaming sessions.
    embed_host_domains: ?[]const []const u8 = null,

    /// The URL that users are redirected to after they click the Send Feedback
    /// link. If no URL is specified, no Send Feedback link is displayed.
    feedback_url: ?[]const u8 = null,

    /// The name of the stack.
    name: []const u8,

    /// The URL that users are redirected to after their streaming session ends.
    redirect_url: ?[]const u8 = null,

    /// The storage connectors to enable.
    storage_connectors: ?[]const StorageConnector = null,

    /// The streaming protocol you want your stack to prefer. This can be UDP or
    /// TCP. Currently, UDP is only supported in the Windows native client.
    streaming_experience_settings: ?StreamingExperienceSettings = null,

    /// The tags to associate with the stack. A tag is a key-value pair, and the
    /// value is optional. For example, Environment=Test. If you do not specify a
    /// value, Environment=.
    ///
    /// If you do not specify a value, the value is set to an empty string.
    ///
    /// Generally allowed characters are: letters, numbers, and spaces representable
    /// in UTF-8, and the following special characters:
    ///
    /// _ . : / = + \ - @
    ///
    /// For more information about tags, see [Tagging Your
    /// Resources](https://docs.aws.amazon.com/appstream2/latest/developerguide/tagging-basic.html) in the *Amazon WorkSpaces Applications Administration Guide*.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The actions that are enabled or disabled for users during their streaming
    /// sessions. By default, these actions are enabled.
    user_settings: ?[]const UserSetting = null,

    pub const json_field_names = .{
        .access_endpoints = "AccessEndpoints",
        .agent_access_config = "AgentAccessConfig",
        .application_settings = "ApplicationSettings",
        .content_redirection = "ContentRedirection",
        .description = "Description",
        .display_name = "DisplayName",
        .embed_host_domains = "EmbedHostDomains",
        .feedback_url = "FeedbackURL",
        .name = "Name",
        .redirect_url = "RedirectURL",
        .storage_connectors = "StorageConnectors",
        .streaming_experience_settings = "StreamingExperienceSettings",
        .tags = "Tags",
        .user_settings = "UserSettings",
    };
};

pub const CreateStackOutput = struct {
    /// Information about the stack.
    stack: ?Stack = null,

    pub const json_field_names = .{
        .stack = "Stack",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateStackInput, options: CallOptions) !CreateStackOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "appstream", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateStackInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("appstream2", "AppStream", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "PhotonAdminProxyService.CreateStack");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateStackOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateStackOutput, body, allocator);
}
