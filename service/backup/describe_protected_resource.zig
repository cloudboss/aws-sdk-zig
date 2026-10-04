const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const DescribeProtectedResourceInput = struct {
    /// An Amazon Resource Name (ARN) that uniquely identifies a resource. The
    /// format of the ARN
    /// depends on the resource type.
    resource_arn: []const u8,

    pub const json_field_names = .{
        .resource_arn = "ResourceArn",
    };
};

pub const DescribeProtectedResourceOutput = struct {
    /// The date and time that a resource was last backed up, in Unix format and
    /// Coordinated
    /// Universal Time (UTC). The value of `LastBackupTime` is accurate to
    /// milliseconds.
    /// For example, the value 1516925490.087 represents Friday, January 26, 2018
    /// 12:11:30.087
    /// AM.
    last_backup_time: ?i64 = null,

    /// The ARN (Amazon Resource Name) of the backup vault
    /// that contains the most recent backup recovery point.
    last_backup_vault_arn: ?[]const u8 = null,

    /// The ARN (Amazon Resource Name) of the most recent
    /// recovery point.
    last_recovery_point_arn: ?[]const u8 = null,

    /// The time, in minutes, that the most recent restore job took to complete.
    latest_restore_execution_time_minutes: ?i64 = null,

    /// The creation date of the most recent restore job.
    latest_restore_job_creation_date: ?i64 = null,

    /// The date the most recent recovery point was created.
    latest_restore_recovery_point_creation_date: ?i64 = null,

    /// An ARN that uniquely identifies a resource. The format of the ARN depends on
    /// the
    /// resource type.
    resource_arn: ?[]const u8 = null,

    /// The name of the resource that belongs to the specified backup.
    resource_name: ?[]const u8 = null,

    /// The type of Amazon Web Services resource saved as a recovery point; for
    /// example, an
    /// Amazon EBS volume or an Amazon RDS database.
    resource_type: ?[]const u8 = null,

    pub const json_field_names = .{
        .last_backup_time = "LastBackupTime",
        .last_backup_vault_arn = "LastBackupVaultArn",
        .last_recovery_point_arn = "LastRecoveryPointArn",
        .latest_restore_execution_time_minutes = "LatestRestoreExecutionTimeMinutes",
        .latest_restore_job_creation_date = "LatestRestoreJobCreationDate",
        .latest_restore_recovery_point_creation_date = "LatestRestoreRecoveryPointCreationDate",
        .resource_arn = "ResourceArn",
        .resource_name = "ResourceName",
        .resource_type = "ResourceType",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeProtectedResourceInput, options: CallOptions) !DescribeProtectedResourceOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeProtectedResourceInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("backup", "Backup", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/resources/");
    try path_buf.appendSlice(allocator, input.resource_arn);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeProtectedResourceOutput {
    const result: DescribeProtectedResourceOutput = try aws.json.parseJsonObject(
        DescribeProtectedResourceOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
