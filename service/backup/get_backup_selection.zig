const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const BackupSelection = @import("backup_selection.zig").BackupSelection;

pub const GetBackupSelectionInput = struct {
    /// Uniquely identifies a backup plan.
    backup_plan_id: []const u8,

    /// Uniquely identifies the body of a request to assign a set of resources to a
    /// backup
    /// plan.
    selection_id: []const u8,

    pub const json_field_names = .{
        .backup_plan_id = "BackupPlanId",
        .selection_id = "SelectionId",
    };
};

pub const GetBackupSelectionOutput = struct {
    /// Uniquely identifies a backup plan.
    backup_plan_id: ?[]const u8 = null,

    /// Specifies the body of a request to assign a set of resources to a backup
    /// plan.
    backup_selection: ?BackupSelection = null,

    /// The date and time a backup selection is created, in Unix format and
    /// Coordinated
    /// Universal Time (UTC). The value of `CreationDate` is accurate to
    /// milliseconds.
    /// For example, the value 1516925490.087 represents Friday, January 26, 2018
    /// 12:11:30.087
    /// AM.
    creation_date: ?i64 = null,

    /// A unique string that identifies the request and allows failed requests to be
    /// retried
    /// without the risk of running the operation twice.
    creator_request_id: ?[]const u8 = null,

    /// Uniquely identifies the body of a request to assign a set of resources to a
    /// backup
    /// plan.
    selection_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .backup_plan_id = "BackupPlanId",
        .backup_selection = "BackupSelection",
        .creation_date = "CreationDate",
        .creator_request_id = "CreatorRequestId",
        .selection_id = "SelectionId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetBackupSelectionInput, options: CallOptions) !GetBackupSelectionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetBackupSelectionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("backup", "Backup", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/backup/plans/");
    try path_buf.appendSlice(allocator, input.backup_plan_id);
    try path_buf.appendSlice(allocator, "/selections/");
    try path_buf.appendSlice(allocator, input.selection_id);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetBackupSelectionOutput {
    var result: GetBackupSelectionOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetBackupSelectionOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
