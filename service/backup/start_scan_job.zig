const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const MalwareScanner = @import("malware_scanner.zig").MalwareScanner;
const ScanMode = @import("scan_mode.zig").ScanMode;

pub const StartScanJobInput = struct {
    /// The name of a logical container where backups are stored. Backup vaults are
    /// identified by names that
    /// are unique to the account used to create them and the Amazon Web Services
    /// Region where they are created.
    ///
    /// Pattern: `^[a-zA-Z0-9\-\_]{2,50}$`
    backup_vault_name: []const u8,

    /// The point in time the scan job will scan up to for a continuous backup.
    continuous_scan_end_time: ?i64 = null,

    /// Specifies the IAM role ARN used to create the target recovery point; for
    /// example,
    /// `arn:aws:iam::123456789012:role/S3Access`.
    iam_role_arn: []const u8,

    /// A customer-chosen string that you can use to distinguish between otherwise
    /// identical
    /// calls to `StartScanJob`. Retrying a successful request with the same
    /// idempotency
    /// token results in a success message with no action taken.
    idempotency_token: ?[]const u8 = null,

    /// Specifies the malware scanner used during the scan job. Currently only
    /// supports `GUARDDUTY`.
    malware_scanner: MalwareScanner,

    /// An Amazon Resource Name (ARN) that uniquely identifies a recovery point.
    /// This is your target recovery point for a full scan.
    /// If you are running an incremental scan, this will be your a recovery point
    /// which has been created after your base recovery point selection.
    recovery_point_arn: []const u8,

    /// An ARN that uniquely identifies the base recovery point to be used for
    /// incremental scanning.
    scan_base_recovery_point_arn: ?[]const u8 = null,

    /// Specifies the scan type use for the scan job.
    ///
    /// Includes:
    ///
    /// * `FULL_SCAN` will scan the entire data lineage within the backup.
    ///
    /// * `INCREMENTAL_SCAN` will scan the data difference between the target
    ///   recovery point and base recovery point ARN.
    scan_mode: ScanMode,

    /// Specified the IAM scanner role ARN.
    scanner_role_arn: []const u8,

    pub const json_field_names = .{
        .backup_vault_name = "BackupVaultName",
        .continuous_scan_end_time = "ContinuousScanEndTime",
        .iam_role_arn = "IamRoleArn",
        .idempotency_token = "IdempotencyToken",
        .malware_scanner = "MalwareScanner",
        .recovery_point_arn = "RecoveryPointArn",
        .scan_base_recovery_point_arn = "ScanBaseRecoveryPointArn",
        .scan_mode = "ScanMode",
        .scanner_role_arn = "ScannerRoleArn",
    };
};

pub const StartScanJobOutput = struct {
    /// The date and time that a backup job is created, in Unix format and
    /// Coordinated Universal
    /// Time (UTC). The value of `CreationDate` is accurate to milliseconds. For
    /// example, the value 1516925490.087 represents Friday, January 26, 2018
    /// 12:11:30.087
    /// AM.
    creation_date: i64,

    /// Uniquely identifies a request to Backup to back up a resource.
    scan_job_id: []const u8,

    pub const json_field_names = .{
        .creation_date = "CreationDate",
        .scan_job_id = "ScanJobId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartScanJobInput, options: CallOptions) !StartScanJobOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: StartScanJobInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("backup", "Backup", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/scan/job";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"BackupVaultName\":");
    try aws.json.writeValue(@TypeOf(input.backup_vault_name), input.backup_vault_name, allocator, &body_buf);
    has_prev = true;
    if (input.continuous_scan_end_time) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ContinuousScanEndTime\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
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
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"MalwareScanner\":");
    try aws.json.writeValue(@TypeOf(input.malware_scanner), input.malware_scanner, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"RecoveryPointArn\":");
    try aws.json.writeValue(@TypeOf(input.recovery_point_arn), input.recovery_point_arn, allocator, &body_buf);
    has_prev = true;
    if (input.scan_base_recovery_point_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ScanBaseRecoveryPointArn\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"ScanMode\":");
    try aws.json.writeValue(@TypeOf(input.scan_mode), input.scan_mode, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"ScannerRoleArn\":");
    try aws.json.writeValue(@TypeOf(input.scanner_role_arn), input.scanner_role_arn, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartScanJobOutput {
    const result: StartScanJobOutput = try aws.json.parseJsonObject(
        StartScanJobOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
