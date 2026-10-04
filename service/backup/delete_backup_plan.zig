const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const DeleteBackupPlanInput = struct {
    /// Uniquely identifies a backup plan.
    backup_plan_id: []const u8,

    pub const json_field_names = .{
        .backup_plan_id = "BackupPlanId",
    };
};

pub const DeleteBackupPlanOutput = struct {
    /// An Amazon Resource Name (ARN) that uniquely identifies a backup plan; for
    /// example,
    /// `arn:aws:backup:us-east-1:123456789012:plan:8F81F553-3A74-4A3F-B93D-B3360DC80C50`.
    backup_plan_arn: ?[]const u8 = null,

    /// Uniquely identifies a backup plan.
    backup_plan_id: ?[]const u8 = null,

    /// The date and time a backup plan is deleted, in Unix format and Coordinated
    /// Universal
    /// Time (UTC). The value of `DeletionDate` is accurate to milliseconds. For
    /// example, the value 1516925490.087 represents Friday, January 26, 2018
    /// 12:11:30.087
    /// AM.
    deletion_date: ?i64 = null,

    /// Unique, randomly generated, Unicode, UTF-8 encoded strings that are at most
    /// 1,024 bytes
    /// long. Version IDs cannot be edited.
    version_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .backup_plan_arn = "BackupPlanArn",
        .backup_plan_id = "BackupPlanId",
        .deletion_date = "DeletionDate",
        .version_id = "VersionId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteBackupPlanInput, options: CallOptions) !DeleteBackupPlanOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteBackupPlanInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("backup", "Backup", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/backup/plans/");
    try path_buf.appendSlice(allocator, input.backup_plan_id);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .DELETE;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteBackupPlanOutput {
    const result: DeleteBackupPlanOutput = try aws.json.parseJsonObject(
        DeleteBackupPlanOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
