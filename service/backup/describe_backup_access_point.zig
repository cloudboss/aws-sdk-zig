const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AccessPointStatus = @import("access_point_status.zig").AccessPointStatus;

pub const DescribeBackupAccessPointInput = struct {
    /// The Amazon Resource Name (ARN) of the backup access point to describe.
    access_point_arn: []const u8,

    pub const json_field_names = .{
        .access_point_arn = "AccessPointArn",
    };
};

pub const DescribeBackupAccessPointOutput = struct {
    /// The Amazon Resource Name (ARN) that uniquely identifies the backup access
    /// point.
    access_point_arn: []const u8,

    /// Metadata for the backup access point. After the backup access point reaches
    /// the `AVAILABLE`
    /// status, this map contains `S3AccessPointArn` and `S3AccessPointAlias`, which
    /// you use with
    /// standard Amazon S3 read APIs to access the backup data. For continuous
    /// recovery points, this map also
    /// contains `AccessPointInTime` (in format `2021-11-27T03:30:27Z`). The access
    /// point
    /// provides access to the content present in the backup at that specific time.
    access_point_metadata: ?[]const aws.map.StringMapEntry = null,

    /// The Amazon Resource Name (ARN) of the backup vault that contains the
    /// recovery point.
    backup_vault_arn: ?[]const u8 = null,

    /// The name of the backup vault that contains the recovery point.
    backup_vault_name: []const u8,

    /// The date and time that the backup access point was created, in Unix format
    /// and Coordinated Universal Time
    /// (UTC). The value of `CreationTime` is accurate to milliseconds. For example,
    /// the value
    /// 1516925490.087 represents Friday, January 26, 2018 12:11:30.087 AM.
    creation_time: i64,

    /// The name of the backup access point.
    name: []const u8,

    /// The Amazon Resource Name (ARN) of the recovery point that the backup access
    /// point provides access to.
    recovery_point_arn: []const u8,

    /// The Amazon Resource Name (ARN) of the resource that was backed up, such as
    /// an Amazon S3 bucket.
    resource_arn: []const u8,

    /// The type of Amazon Web Services resource associated with the recovery point.
    /// For example, `S3` for
    /// Amazon Simple Storage Service.
    resource_type: []const u8,

    /// The current status of the backup access point.
    status: AccessPointStatus,

    /// A message that provides additional detail about the status of the backup
    /// access point, such as the reason a
    /// creation or deletion attempt failed.
    status_message: ?[]const u8 = null,

    pub const json_field_names = .{
        .access_point_arn = "AccessPointArn",
        .access_point_metadata = "AccessPointMetadata",
        .backup_vault_arn = "BackupVaultArn",
        .backup_vault_name = "BackupVaultName",
        .creation_time = "CreationTime",
        .name = "Name",
        .recovery_point_arn = "RecoveryPointArn",
        .resource_arn = "ResourceArn",
        .resource_type = "ResourceType",
        .status = "Status",
        .status_message = "StatusMessage",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeBackupAccessPointInput, options: CallOptions) !DescribeBackupAccessPointOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeBackupAccessPointInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("backup", "Backup", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/backup-access-point/");
    try path_buf.appendSlice(allocator, input.access_point_arn);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeBackupAccessPointOutput {
    const result: DescribeBackupAccessPointOutput = try aws.json.parseJsonObject(
        DescribeBackupAccessPointOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
