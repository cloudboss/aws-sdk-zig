const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AuthenticationProviderTypes = @import("authentication_provider_types.zig").AuthenticationProviderTypes;
const SamlConfiguration = @import("saml_configuration.zig").SamlConfiguration;
const AuthenticationDescription = @import("authentication_description.zig").AuthenticationDescription;

pub const UpdateWorkspaceAuthenticationInput = struct {
    /// Specifies whether this workspace uses SAML 2.0, IAM Identity Center, or both
    /// to authenticate users for using the Grafana console within a workspace. For
    /// more information, see [User authentication in Amazon Managed
    /// Grafana](https://docs.aws.amazon.com/grafana/latest/userguide/authentication-in-AMG.html).
    authentication_providers: []const AuthenticationProviderTypes,

    /// If the workspace uses SAML, use this structure to map SAML assertion
    /// attributes to workspace user information and define which groups in the
    /// assertion attribute are to have the `Admin` and `Editor` roles in the
    /// workspace.
    saml_configuration: ?SamlConfiguration = null,

    /// The ID of the workspace to update the authentication for.
    workspace_id: []const u8,

    pub const json_field_names = .{
        .authentication_providers = "authenticationProviders",
        .saml_configuration = "samlConfiguration",
        .workspace_id = "workspaceId",
    };
};

pub const UpdateWorkspaceAuthenticationOutput = struct {
    /// A structure that describes the user authentication for this workspace after
    /// the update is made.
    authentication: ?AuthenticationDescription = null,

    pub const json_field_names = .{
        .authentication = "authentication",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateWorkspaceAuthenticationInput, options: CallOptions) !UpdateWorkspaceAuthenticationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "grafana", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateWorkspaceAuthenticationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("grafana", "grafana", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/workspaces/");
    try path_buf.appendSlice(allocator, input.workspace_id);
    try path_buf.appendSlice(allocator, "/authentication");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"authenticationProviders\":");
    try aws.json.writeValue(@TypeOf(input.authentication_providers), input.authentication_providers, allocator, &body_buf);
    has_prev = true;
    if (input.saml_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"samlConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateWorkspaceAuthenticationOutput {
    const result: UpdateWorkspaceAuthenticationOutput = try aws.json.parseJsonObject(
        UpdateWorkspaceAuthenticationOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
