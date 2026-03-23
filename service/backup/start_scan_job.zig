const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
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
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "backup");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: StartScanJobInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("backup", "Backup", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/scan/job";

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"BackupVaultName\":");
    try aws.json.writeValue(@TypeOf(input.backup_vault_name), input.backup_vault_name, allocator, &body_buf);
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

    var request = aws.http.Request.init(host);
    request.method = .PUT;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartScanJobOutput {
    var result: StartScanJobOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(StartScanJobOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "AlreadyExistsException")) {
        return .{ .arena = arena, .kind = .{ .already_exists_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DependencyFailureException")) {
        return .{ .arena = arena, .kind = .{ .dependency_failure_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidParameterValueException")) {
        return .{ .arena = arena, .kind = .{ .invalid_parameter_value_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidRequestException")) {
        return .{ .arena = arena, .kind = .{ .invalid_request_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidResourceStateException")) {
        return .{ .arena = arena, .kind = .{ .invalid_resource_state_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "LimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "MissingParameterValueException")) {
        return .{ .arena = arena, .kind = .{ .missing_parameter_value_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceUnavailableException")) {
        return .{ .arena = arena, .kind = .{ .service_unavailable_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
