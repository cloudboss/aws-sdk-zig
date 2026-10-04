const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Role = @import("role.zig").Role;

pub const CreateWorkspaceServiceAccountInput = struct {
    /// The permission level to use for this service account.
    ///
    /// For more information about the roles and the permissions each has, see [User
    /// roles](https://docs.aws.amazon.com/grafana/latest/userguide/Grafana-user-roles.html) in the *Amazon Managed Grafana User Guide*.
    grafana_role: Role,

    /// A name for the service account. The name must be unique within the
    /// workspace, as it determines the ID associated with the service account.
    name: []const u8,

    /// The ID of the workspace within which to create the service account.
    workspace_id: []const u8,

    pub const json_field_names = .{
        .grafana_role = "grafanaRole",
        .name = "name",
        .workspace_id = "workspaceId",
    };
};

pub const CreateWorkspaceServiceAccountOutput = struct {
    /// The permission level given to the service account.
    grafana_role: Role,

    /// The ID of the service account.
    id: []const u8,

    /// The name of the service account.
    name: []const u8,

    /// The workspace with which the service account is associated.
    workspace_id: []const u8,

    pub const json_field_names = .{
        .grafana_role = "grafanaRole",
        .id = "id",
        .name = "name",
        .workspace_id = "workspaceId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateWorkspaceServiceAccountInput, options: CallOptions) !CreateWorkspaceServiceAccountOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateWorkspaceServiceAccountInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("grafana", "grafana", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/workspaces/");
    try path_buf.appendSlice(allocator, input.workspace_id);
    try path_buf.appendSlice(allocator, "/serviceaccounts");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"grafanaRole\":");
    try aws.json.writeValue(@TypeOf(input.grafana_role), input.grafana_role, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
    has_prev = true;

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateWorkspaceServiceAccountOutput {
    var result: CreateWorkspaceServiceAccountOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateWorkspaceServiceAccountOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
