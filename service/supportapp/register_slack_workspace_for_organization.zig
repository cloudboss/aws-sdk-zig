const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AccountType = @import("account_type.zig").AccountType;

pub const RegisterSlackWorkspaceForOrganizationInput = struct {
    /// The team ID in Slack. This ID uniquely identifies a Slack workspace, such as
    /// `T012ABCDEFG`. Specify the Slack workspace that you want to use for your
    /// organization.
    team_id: []const u8,

    pub const json_field_names = .{
        .team_id = "teamId",
    };
};

pub const RegisterSlackWorkspaceForOrganizationOutput = struct {
    /// Whether the Amazon Web Services account is a management or member account
    /// that's part of an organization
    /// in Organizations.
    account_type: ?AccountType = null,

    /// The team ID in Slack. This ID uniquely identifies a Slack workspace, such as
    /// `T012ABCDEFG`.
    team_id: ?[]const u8 = null,

    /// The name of the Slack workspace.
    team_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .account_type = "accountType",
        .team_id = "teamId",
        .team_name = "teamName",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: RegisterSlackWorkspaceForOrganizationInput, options: CallOptions) !RegisterSlackWorkspaceForOrganizationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "supportapp", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: RegisterSlackWorkspaceForOrganizationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("supportapp", "Support App", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/control/register-slack-workspace-for-organization";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"teamId\":");
    try aws.json.writeValue(@TypeOf(input.team_id), input.team_id, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !RegisterSlackWorkspaceForOrganizationOutput {
    const result: RegisterSlackWorkspaceForOrganizationOutput = try aws.json.parseJsonObject(
        RegisterSlackWorkspaceForOrganizationOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
