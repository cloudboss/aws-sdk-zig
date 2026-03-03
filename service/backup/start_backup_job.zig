const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const Index = @import("index.zig").Index;
const Lifecycle = @import("lifecycle.zig").Lifecycle;

pub const StartBackupJobInput = struct {
    /// The backup option for a selected resource. This option is only available for
    /// Windows Volume Shadow Copy Service (VSS) backup jobs.
    ///
    /// Valid values: Set to `"WindowsVSS":"enabled"` to enable the
    /// `WindowsVSS` backup option and create a Windows VSS backup. Set to
    /// `"WindowsVSS""disabled"` to create a regular backup. The
    /// `WindowsVSS` option is not enabled by default.
    backup_options: ?[]const aws.map.StringMapEntry = null,

    /// The name of a logical container where backups are stored. Backup vaults are
    /// identified
    /// by names that are unique to the account used to create them and the Amazon
    /// Web Services
    /// Region where they are created.
    backup_vault_name: []const u8,

    /// A value in minutes during which a successfully started backup must complete,
    /// or else
    /// Backup will cancel the job. This value is optional. This value begins
    /// counting down from when the backup was scheduled. It does not add additional
    /// time for
    /// `StartWindowMinutes`, or if the backup started later than scheduled.
    ///
    /// Like `StartWindowMinutes`, this parameter has a maximum value of
    /// 100 years (52,560,000 minutes).
    complete_window_minutes: ?i64 = null,

    /// Specifies the IAM role ARN used to create the target recovery point; for
    /// example,
    /// `arn:aws:iam::123456789012:role/S3Access`.
    iam_role_arn: []const u8,

    /// A customer-chosen string that you can use to distinguish between otherwise
    /// identical
    /// calls to `StartBackupJob`. Retrying a successful request with the same
    /// idempotency token results in a success message with no action taken.
    idempotency_token: ?[]const u8 = null,

    /// Include this parameter to enable index creation if your backup
    /// job has a resource type that supports backup indexes.
    ///
    /// Resource types that support backup indexes include:
    ///
    /// * `EBS` for Amazon Elastic Block Store
    ///
    /// * `S3` for Amazon Simple Storage Service (Amazon S3)
    ///
    /// Index can have 1 of 2 possible values, either `ENABLED` or
    /// `DISABLED`.
    ///
    /// To create a backup index for an eligible `ACTIVE` recovery point
    /// that does not yet have a backup index, set value to `ENABLED`.
    ///
    /// To delete a backup index, set value to `DISABLED`.
    index: ?Index = null,

    /// The lifecycle defines when a protected resource is transitioned to cold
    /// storage and when
    /// it expires. Backup will transition and expire backups automatically
    /// according
    /// to the lifecycle that you define.
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
    /// [Feature
    /// availability by
    /// resource](https://docs.aws.amazon.com/aws-backup/latest/devguide/backup-feature-availability.html#features-by-resource) table. Backup ignores this expression for
    /// other resource types.
    ///
    /// This parameter has a maximum value of 100 years (36,500 days).
    lifecycle: ?Lifecycle = null,

    /// The ARN of a logically air-gapped vault. ARN must be in the same account and
    /// Region.
    /// If provided, supported fully managed resources back up directly to logically
    /// air-gapped vault,
    /// while other supported resources create a temporary (billable) snapshot in
    /// backup vault,
    /// then copy it to logically air-gapped vault. Unsupported resources only back
    /// up to the specified
    /// backup vault.
    logically_air_gapped_backup_vault_arn: ?[]const u8 = null,

    /// The tags to assign to the resources.
    recovery_point_tags: ?[]const aws.map.StringMapEntry = null,

    /// An Amazon Resource Name (ARN) that uniquely identifies a resource. The
    /// format of the ARN
    /// depends on the resource type.
    resource_arn: []const u8,

    /// A value in minutes after a backup is scheduled before a job will be canceled
    /// if it
    /// doesn't start successfully. This value is optional, and the default is 8
    /// hours.
    /// If this value is included, it must be at least 60 minutes to avoid errors.
    ///
    /// This parameter has a maximum value of 100 years (52,560,000 minutes).
    ///
    /// During the start window, the backup job status remains in `CREATED` status
    /// until it
    /// has successfully begun or until the start window time has run out. If within
    /// the start
    /// window time Backup receives an error that allows the job to be retried,
    /// Backup will automatically retry to begin the job at least every 10 minutes
    /// until the backup
    /// successfully begins (the job status changes to `RUNNING`) or until the job
    /// status
    /// changes to `EXPIRED` (which is expected to occur when the start window time
    /// is over).
    start_window_minutes: ?i64 = null,

    pub const json_field_names = .{
        .backup_options = "BackupOptions",
        .backup_vault_name = "BackupVaultName",
        .complete_window_minutes = "CompleteWindowMinutes",
        .iam_role_arn = "IamRoleArn",
        .idempotency_token = "IdempotencyToken",
        .index = "Index",
        .lifecycle = "Lifecycle",
        .logically_air_gapped_backup_vault_arn = "LogicallyAirGappedBackupVaultArn",
        .recovery_point_tags = "RecoveryPointTags",
        .resource_arn = "ResourceArn",
        .start_window_minutes = "StartWindowMinutes",
    };
};

pub const StartBackupJobOutput = struct {
    /// Uniquely identifies a request to Backup to back up a resource.
    backup_job_id: ?[]const u8 = null,

    /// The date and time that a backup job is created, in Unix format and
    /// Coordinated Universal
    /// Time (UTC). The value of `CreationDate` is accurate to milliseconds. For
    /// example, the value 1516925490.087 represents Friday, January 26, 2018
    /// 12:11:30.087
    /// AM.
    creation_date: ?i64 = null,

    /// This is a returned boolean value indicating this is a parent (composite)
    /// backup job.
    is_parent: ?bool = null,

    /// *Note: This field is only returned for Amazon EFS and Advanced DynamoDB
    /// resources.*
    ///
    /// An ARN that uniquely identifies a recovery point; for example,
    /// `arn:aws:backup:us-east-1:123456789012:recovery-point:1EB3B5E7-9EB0-435A-A80B-108B488B0D45`.
    recovery_point_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .backup_job_id = "BackupJobId",
        .creation_date = "CreationDate",
        .is_parent = "IsParent",
        .recovery_point_arn = "RecoveryPointArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartBackupJobInput, options: CallOptions) !StartBackupJobOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: StartBackupJobInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("backup", "Backup", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/backup-jobs";

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.backup_options) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"BackupOptions\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"BackupVaultName\":");
    try aws.json.writeValue(@TypeOf(input.backup_vault_name), input.backup_vault_name, allocator, &body_buf);
    has_prev = true;
    if (input.complete_window_minutes) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"CompleteWindowMinutes\":");
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
    if (input.index) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Index\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.lifecycle) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Lifecycle\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.logically_air_gapped_backup_vault_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"LogicallyAirGappedBackupVaultArn\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.recovery_point_tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"RecoveryPointTags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"ResourceArn\":");
    try aws.json.writeValue(@TypeOf(input.resource_arn), input.resource_arn, allocator, &body_buf);
    has_prev = true;
    if (input.start_window_minutes) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"StartWindowMinutes\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartBackupJobOutput {
    var result: StartBackupJobOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(StartBackupJobOutput, body, allocator);
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
