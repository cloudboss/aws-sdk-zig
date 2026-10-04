const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const AssociateBackupVaultMpaApprovalTeamInput = struct {
    /// The name of the backup vault to associate with the MPA approval team.
    backup_vault_name: []const u8,

    /// The Amazon Resource Name (ARN) of the MPA approval team to associate with
    /// the backup vault.
    mpa_approval_team_arn: []const u8,

    /// A comment provided by the requester explaining the association request.
    requester_comment: ?[]const u8 = null,

    pub const json_field_names = .{
        .backup_vault_name = "BackupVaultName",
        .mpa_approval_team_arn = "MpaApprovalTeamArn",
        .requester_comment = "RequesterComment",
    };
};

pub const AssociateBackupVaultMpaApprovalTeamOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: AssociateBackupVaultMpaApprovalTeamInput, options: CallOptions) !AssociateBackupVaultMpaApprovalTeamOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "backup", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: AssociateBackupVaultMpaApprovalTeamInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("backup", "Backup", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/backup-vaults/");
    try path_buf.appendSlice(allocator, input.backup_vault_name);
    try path_buf.appendSlice(allocator, "/mpaApprovalTeam");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"MpaApprovalTeamArn\":");
    try aws.json.writeValue(@TypeOf(input.mpa_approval_team_arn), input.mpa_approval_team_arn, allocator, &body_buf);
    has_prev = true;
    if (input.requester_comment) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"RequesterComment\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !AssociateBackupVaultMpaApprovalTeamOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: AssociateBackupVaultMpaApprovalTeamOutput = .{};

    return result;
}
