const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const LicenseType = @import("license_type.zig").LicenseType;
const WorkspaceDescription = @import("workspace_description.zig").WorkspaceDescription;

pub const AssociateLicenseInput = struct {
    /// A token from Grafana Labs that ties your Amazon Web Services account with a
    /// Grafana Labs account. For more information, see [Link your account with
    /// Grafana
    /// Labs](https://docs.aws.amazon.com/grafana/latest/userguide/upgrade-to-Grafana-Enterprise.html#AMG-workspace-register-enterprise).
    grafana_token: ?[]const u8 = null,

    /// The type of license to associate with the workspace.
    ///
    /// Amazon Managed Grafana workspaces no longer support Grafana Enterprise free
    /// trials.
    license_type: LicenseType,

    /// The ID of the workspace to associate the license with.
    workspace_id: []const u8,

    pub const json_field_names = .{
        .grafana_token = "grafanaToken",
        .license_type = "licenseType",
        .workspace_id = "workspaceId",
    };
};

pub const AssociateLicenseOutput = struct {
    /// A structure containing data about the workspace.
    workspace: ?WorkspaceDescription = null,

    pub const json_field_names = .{
        .workspace = "workspace",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: AssociateLicenseInput, options: CallOptions) !AssociateLicenseOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: AssociateLicenseInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("grafana", "grafana", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/workspaces/");
    try path_buf.appendSlice(allocator, input.workspace_id);
    try path_buf.appendSlice(allocator, "/licenses/");
    try path_buf.appendSlice(allocator, input.license_type.wireName());
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");
    if (input.grafana_token) |v| {
        try request.headers.put(allocator, "Grafana-Token", v);
    }

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !AssociateLicenseOutput {
    const result: AssociateLicenseOutput = try aws.json.parseJsonObject(
        AssociateLicenseOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
