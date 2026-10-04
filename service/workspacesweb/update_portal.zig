const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AuthenticationType = @import("authentication_type.zig").AuthenticationType;
const InstanceType = @import("instance_type.zig").InstanceType;
const Portal = @import("portal.zig").Portal;

pub const UpdatePortalInput = struct {
    /// The type of authentication integration points used when signing into the web
    /// portal. Defaults to `Standard`.
    ///
    /// `Standard` web portals are authenticated directly through your identity
    /// provider. You need to call `CreateIdentityProvider` to integrate your
    /// identity provider with your web portal. User and group access to your web
    /// portal is controlled through your identity provider.
    ///
    /// `IAM Identity Center` web portals are authenticated through IAM Identity
    /// Center. Identity sources (including external identity provider integration),
    /// plus user and group access to your web portal, can be configured in the IAM
    /// Identity Center.
    authentication_type: ?AuthenticationType = null,

    /// The name of the web portal. This is not visible to users who log into the
    /// web portal.
    display_name: ?[]const u8 = null,

    /// The type and resources of the underlying instance.
    instance_type: ?InstanceType = null,

    /// The maximum number of concurrent sessions for the portal.
    max_concurrent_sessions: ?i32 = null,

    /// The ARN of the web portal.
    portal_arn: []const u8,

    /// The custom domain of the web portal that users access in order to start
    /// streaming sessions.
    portal_custom_domain: ?[]const u8 = null,

    pub const json_field_names = .{
        .authentication_type = "authenticationType",
        .display_name = "displayName",
        .instance_type = "instanceType",
        .max_concurrent_sessions = "maxConcurrentSessions",
        .portal_arn = "portalArn",
        .portal_custom_domain = "portalCustomDomain",
    };
};

pub const UpdatePortalOutput = struct {
    /// The web portal.
    portal: ?Portal = null,

    pub const json_field_names = .{
        .portal = "portal",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdatePortalInput, options: CallOptions) !UpdatePortalOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "workspaces-web", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdatePortalInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("workspaces-web", "WorkSpaces Web", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/portals/");
    try path_buf.appendSlice(allocator, input.portal_arn);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.authentication_type) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"authenticationType\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.display_name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"displayName\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.instance_type) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"instanceType\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.max_concurrent_sessions) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"maxConcurrentSessions\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.portal_custom_domain) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"portalCustomDomain\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdatePortalOutput {
    var result: UpdatePortalOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdatePortalOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
