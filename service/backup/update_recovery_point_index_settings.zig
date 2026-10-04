const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Index = @import("index.zig").Index;
const IndexStatus = @import("index_status.zig").IndexStatus;

pub const UpdateRecoveryPointIndexSettingsInput = struct {
    /// The name of a logical container where backups are stored. Backup vaults are
    /// identified
    /// by names that are unique to the account used to create them and the Region
    /// where they are
    /// created.
    ///
    /// Accepted characters include lowercase letters, numbers, and hyphens.
    backup_vault_name: []const u8,

    /// This specifies the IAM role ARN used for this operation.
    ///
    /// For example, arn:aws:iam::123456789012:role/S3Access
    iam_role_arn: ?[]const u8 = null,

    /// Index can have 1 of 2 possible values, either `ENABLED` or
    /// `DISABLED`.
    ///
    /// To create a backup index for an eligible `ACTIVE` recovery point
    /// that does not yet have a backup index, set value to `ENABLED`.
    ///
    /// To delete a backup index, set value to `DISABLED`.
    index: Index,

    /// An ARN that uniquely identifies a recovery point; for example,
    /// `arn:aws:backup:us-east-1:123456789012:recovery-point:1EB3B5E7-9EB0-435A-A80B-108B488B0D45`.
    recovery_point_arn: []const u8,

    pub const json_field_names = .{
        .backup_vault_name = "BackupVaultName",
        .iam_role_arn = "IamRoleArn",
        .index = "Index",
        .recovery_point_arn = "RecoveryPointArn",
    };
};

pub const UpdateRecoveryPointIndexSettingsOutput = struct {
    /// The name of a logical container where backups are stored. Backup vaults are
    /// identified
    /// by names that are unique to the account used to create them and the Region
    /// where they are
    /// created.
    backup_vault_name: ?[]const u8 = null,

    /// Index can have 1 of 2 possible values, either `ENABLED` or
    /// `DISABLED`.
    ///
    /// A value of `ENABLED` means a backup index for an eligible `ACTIVE`
    /// recovery point has been created.
    ///
    /// A value of `DISABLED` means a backup index was deleted.
    index: ?Index = null,

    /// This is the current status for the backup index associated
    /// with the specified recovery point.
    ///
    /// Statuses are: `PENDING` | `ACTIVE` | `FAILED` | `DELETING`
    ///
    /// A recovery point with an index that has the status of `ACTIVE`
    /// can be included in a search.
    index_status: ?IndexStatus = null,

    /// An ARN that uniquely identifies a recovery point; for example,
    /// `arn:aws:backup:us-east-1:123456789012:recovery-point:1EB3B5E7-9EB0-435A-A80B-108B488B0D45`.
    recovery_point_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .backup_vault_name = "BackupVaultName",
        .index = "Index",
        .index_status = "IndexStatus",
        .recovery_point_arn = "RecoveryPointArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateRecoveryPointIndexSettingsInput, options: CallOptions) !UpdateRecoveryPointIndexSettingsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateRecoveryPointIndexSettingsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("backup", "Backup", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/backup-vaults/");
    try path_buf.appendSlice(allocator, input.backup_vault_name);
    try path_buf.appendSlice(allocator, "/recovery-points/");
    try path_buf.appendSlice(allocator, input.recovery_point_arn);
    try path_buf.appendSlice(allocator, "/index");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.iam_role_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"IamRoleArn\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Index\":");
    try aws.json.writeValue(@TypeOf(input.index), input.index, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateRecoveryPointIndexSettingsOutput {
    var result: UpdateRecoveryPointIndexSettingsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateRecoveryPointIndexSettingsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
