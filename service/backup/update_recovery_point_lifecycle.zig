const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const Lifecycle = @import("lifecycle.zig").Lifecycle;
const CalculatedLifecycle = @import("calculated_lifecycle.zig").CalculatedLifecycle;

pub const UpdateRecoveryPointLifecycleInput = struct {
    /// The name of a logical container where backups are stored. Backup vaults are
    /// identified
    /// by names that are unique to the account used to create them and the Amazon
    /// Web Services
    /// Region where they are created.
    backup_vault_name: []const u8,

    /// The lifecycle defines when a protected resource is transitioned to cold
    /// storage and when
    /// it expires. Backup transitions and expires backups automatically according
    /// to
    /// the lifecycle that you define.
    ///
    /// Backups transitioned to cold storage must be stored in cold storage for a
    /// minimum of 90
    /// days. Therefore, the “retention” setting must be 90 days greater than the
    /// “transition to
    /// cold after days” setting. The “transition to cold after days” setting cannot
    /// be changed
    /// after a backup has been transitioned to cold.
    lifecycle: ?Lifecycle = null,

    /// An Amazon Resource Name (ARN) that uniquely identifies a recovery point; for
    /// example,
    /// `arn:aws:backup:us-east-1:123456789012:recovery-point:1EB3B5E7-9EB0-435A-A80B-108B488B0D45`.
    recovery_point_arn: []const u8,

    pub const json_field_names = .{
        .backup_vault_name = "BackupVaultName",
        .lifecycle = "Lifecycle",
        .recovery_point_arn = "RecoveryPointArn",
    };
};

pub const UpdateRecoveryPointLifecycleOutput = struct {
    /// An ARN that uniquely identifies a backup vault; for example,
    /// `arn:aws:backup:us-east-1:123456789012:backup-vault:aBackupVault`.
    backup_vault_arn: ?[]const u8 = null,

    /// A `CalculatedLifecycle` object containing `DeleteAt` and
    /// `MoveToColdStorageAt` timestamps.
    calculated_lifecycle: ?CalculatedLifecycle = null,

    /// The lifecycle defines when a protected resource is transitioned to cold
    /// storage and when
    /// it expires. Backup transitions and expires backups automatically according
    /// to
    /// the lifecycle that you define.
    ///
    /// Backups transitioned to cold storage must be stored in cold storage for a
    /// minimum of 90
    /// days. Therefore, the “retention” setting must be 90 days greater than the
    /// “transition to
    /// cold after days” setting. The “transition to cold after days” setting cannot
    /// be changed
    /// after a backup has been transitioned to cold.
    ///
    /// Resource types that can transition to cold storage are listed in the
    /// [Feature availability
    /// by
    /// resource](https://docs.aws.amazon.com/aws-backup/latest/devguide/backup-feature-availability.html#features-by-resource) table. Backup ignores this expression for other resource types.
    lifecycle: ?Lifecycle = null,

    /// An Amazon Resource Name (ARN) that uniquely identifies a recovery point; for
    /// example,
    /// `arn:aws:backup:us-east-1:123456789012:recovery-point:1EB3B5E7-9EB0-435A-A80B-108B488B0D45`.
    recovery_point_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .backup_vault_arn = "BackupVaultArn",
        .calculated_lifecycle = "CalculatedLifecycle",
        .lifecycle = "Lifecycle",
        .recovery_point_arn = "RecoveryPointArn",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateRecoveryPointLifecycleInput, options: Options) !UpdateRecoveryPointLifecycleOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateRecoveryPointLifecycleInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("backup", "Backup", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/backup-vaults/");
    try path_buf.appendSlice(allocator, input.backup_vault_name);
    try path_buf.appendSlice(allocator, "/recovery-points/");
    try path_buf.appendSlice(allocator, input.recovery_point_arn);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.lifecycle) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Lifecycle\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateRecoveryPointLifecycleOutput {
    var result: UpdateRecoveryPointLifecycleOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateRecoveryPointLifecycleOutput, body, allocator);
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
