const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;

pub const PutBackupVaultLockConfigurationInput = struct {
    /// The Backup Vault Lock configuration that specifies the name of the backup
    /// vault it protects.
    backup_vault_name: []const u8,

    /// The Backup Vault Lock configuration that specifies the number of days before
    /// the lock date. For example, setting `ChangeableForDays` to 30 on Jan. 1,
    /// 2022 at
    /// 8pm UTC will set the lock date to Jan. 31, 2022 at 8pm UTC.
    ///
    /// Backup enforces a 72-hour cooling-off period before Vault Lock takes effect
    /// and becomes immutable. Therefore, you must set `ChangeableForDays` to 3 or
    /// greater.
    ///
    /// Before the lock date, you can delete Vault Lock from the vault using
    /// `DeleteBackupVaultLockConfiguration` or change the Vault Lock configuration
    /// using `PutBackupVaultLockConfiguration`. On and after the lock date, the
    /// Vault
    /// Lock becomes immutable and cannot be changed or deleted.
    ///
    /// If this parameter is not specified, you can delete Vault Lock from the vault
    /// using
    /// `DeleteBackupVaultLockConfiguration` or change the Vault Lock configuration
    /// using `PutBackupVaultLockConfiguration` at any time.
    changeable_for_days: ?i64 = null,

    /// The Backup Vault Lock configuration that specifies the maximum retention
    /// period that the vault retains its recovery points. This setting can be
    /// useful if, for
    /// example, your organization's policies require you to destroy certain data
    /// after retaining
    /// it for four years (1460 days).
    ///
    /// If this parameter is not included, Vault Lock does not enforce a maximum
    /// retention
    /// period on the recovery points in the vault. If this parameter is included
    /// without a value,
    /// Vault Lock will not enforce a maximum retention period.
    ///
    /// If this parameter is specified, any backup or copy job to the vault must
    /// have a
    /// lifecycle policy with a retention period equal to or shorter than the
    /// maximum retention
    /// period. If the job's retention period is longer than that maximum retention
    /// period, then
    /// the vault fails the backup or copy job, and you should either modify your
    /// lifecycle
    /// settings or use a different vault. The longest maximum retention period
    /// you can specify is 36500 days (approximately 100 years).
    /// Recovery points already saved in the vault prior to
    /// Vault Lock are not affected.
    max_retention_days: ?i64 = null,

    /// The Backup Vault Lock configuration that specifies the minimum retention
    /// period that the vault retains its recovery points. This setting can be
    /// useful if, for
    /// example, your organization's policies require you to retain certain data for
    /// at least seven
    /// years (2555 days).
    ///
    /// This parameter is required when a vault lock is created through
    /// CloudFormation;
    /// otherwise, this parameter is optional. If this parameter is not specified,
    /// Vault Lock will
    /// not enforce a minimum retention period.
    ///
    /// If this parameter is specified, any backup or copy job to the vault must
    /// have a
    /// lifecycle policy with a retention period equal to or longer than the minimum
    /// retention
    /// period. If the job's retention period is shorter than that minimum retention
    /// period, then
    /// the vault fails that backup or copy job, and you should either modify your
    /// lifecycle
    /// settings or use a different vault. The shortest minimum retention period
    /// you can specify is 1 day. Recovery points already saved in the vault prior
    /// to
    /// Vault Lock are not affected.
    min_retention_days: ?i64 = null,

    pub const json_field_names = .{
        .backup_vault_name = "BackupVaultName",
        .changeable_for_days = "ChangeableForDays",
        .max_retention_days = "MaxRetentionDays",
        .min_retention_days = "MinRetentionDays",
    };
};

const PutBackupVaultLockConfigurationOutput = struct {};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutBackupVaultLockConfigurationInput, options: Options) !PutBackupVaultLockConfigurationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
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

fn serializeRequest(allocator: std.mem.Allocator, input: PutBackupVaultLockConfigurationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("backup", "Backup", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/backup-vaults/");
    try path_buf.appendSlice(allocator, input.backup_vault_name);
    try path_buf.appendSlice(allocator, "/vault-lock");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.changeable_for_days) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ChangeableForDays\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.max_retention_days) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"MaxRetentionDays\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.min_retention_days) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"MinRetentionDays\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutBackupVaultLockConfigurationOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: PutBackupVaultLockConfigurationOutput = .{};

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
