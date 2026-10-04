const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Lifecycle = @import("lifecycle.zig").Lifecycle;

pub const StartCopyJobInput = struct {
    /// An Amazon Resource Name (ARN) that uniquely identifies a destination backup
    /// vault to
    /// copy to; for example,
    /// `arn:aws:backup:us-east-1:123456789012:backup-vault:aBackupVault`.
    destination_backup_vault_arn: []const u8,

    /// Specifies the IAM role ARN used to copy the target recovery point; for
    /// example,
    /// `arn:aws:iam::123456789012:role/S3Access`.
    iam_role_arn: []const u8,

    /// A customer-chosen string that you can use to distinguish between otherwise
    /// identical
    /// calls to `StartCopyJob`. Retrying a successful request with the same
    /// idempotency
    /// token results in a success message with no action taken.
    idempotency_token: ?[]const u8 = null,

    lifecycle: ?Lifecycle = null,

    /// An ARN that uniquely identifies a recovery point to use for the copy job;
    /// for example,
    /// arn:aws:backup:us-east-1:123456789012:recovery-point:1EB3B5E7-9EB0-435A-A80B-108B488B0D45.
    recovery_point_arn: []const u8,

    /// The name of a logical source container where backups are stored. Backup
    /// vaults are
    /// identified by names that are unique to the account used to create them and
    /// the Amazon Web Services Region where they are created.
    source_backup_vault_name: []const u8,

    pub const json_field_names = .{
        .destination_backup_vault_arn = "DestinationBackupVaultArn",
        .iam_role_arn = "IamRoleArn",
        .idempotency_token = "IdempotencyToken",
        .lifecycle = "Lifecycle",
        .recovery_point_arn = "RecoveryPointArn",
        .source_backup_vault_name = "SourceBackupVaultName",
    };
};

pub const StartCopyJobOutput = struct {
    /// Uniquely identifies a copy job.
    copy_job_id: ?[]const u8 = null,

    /// The date and time that a copy job is created, in Unix format and Coordinated
    /// Universal
    /// Time (UTC). The value of `CreationDate` is accurate to milliseconds. For
    /// example, the value 1516925490.087 represents Friday, January 26, 2018
    /// 12:11:30.087
    /// AM.
    creation_date: ?i64 = null,

    /// This is a returned boolean value indicating this is a parent (composite)
    /// copy job.
    is_parent: ?bool = null,

    pub const json_field_names = .{
        .copy_job_id = "CopyJobId",
        .creation_date = "CreationDate",
        .is_parent = "IsParent",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartCopyJobInput, options: CallOptions) !StartCopyJobOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: StartCopyJobInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("backup", "Backup", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/copy-jobs";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"DestinationBackupVaultArn\":");
    try aws.json.writeValue(@TypeOf(input.destination_backup_vault_arn), input.destination_backup_vault_arn, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"IamRoleArn\":");
    try aws.json.writeValue(@TypeOf(input.iam_role_arn), input.iam_role_arn, allocator, &body_buf);
    has_prev = true;
    if (input.idempotency_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"IdempotencyToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.lifecycle) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Lifecycle\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"RecoveryPointArn\":");
    try aws.json.writeValue(@TypeOf(input.recovery_point_arn), input.recovery_point_arn, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"SourceBackupVaultName\":");
    try aws.json.writeValue(@TypeOf(input.source_backup_vault_name), input.source_backup_vault_name, allocator, &body_buf);
    has_prev = true;

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartCopyJobOutput {
    var result: StartCopyJobOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(StartCopyJobOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
