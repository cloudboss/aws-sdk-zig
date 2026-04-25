const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;

pub const StartRestoreJobInput = struct {
    /// This is an optional parameter. If this equals `True`, tags included in the
    /// backup
    /// will be copied to the restored resource.
    ///
    /// This can only be applied to backups created through Backup.
    copy_source_tags_to_restored_resource: ?bool = null,

    /// The Amazon Resource Name (ARN) of the IAM role that Backup uses to create
    /// the target resource; for example:
    /// `arn:aws:iam::123456789012:role/S3Access`.
    iam_role_arn: ?[]const u8 = null,

    /// A customer-chosen string that you can use to distinguish between otherwise
    /// identical
    /// calls to `StartRestoreJob`. Retrying a successful request with the same
    /// idempotency token results in a success message with no action taken.
    idempotency_token: ?[]const u8 = null,

    /// A set of metadata key-value pairs.
    ///
    /// You can get configuration metadata about a resource at the time it was
    /// backed up by
    /// calling `GetRecoveryPointRestoreMetadata`. However, values in addition to
    /// those
    /// provided by `GetRecoveryPointRestoreMetadata` might be required to restore a
    /// resource. For example, you might need to provide a new resource name if the
    /// original
    /// already exists.
    ///
    /// For more information about the metadata for each resource, see the
    /// following:
    ///
    /// * [Metadata for Amazon
    ///   Aurora](https://docs.aws.amazon.com/aws-backup/latest/devguide/restoring-aur.html#aur-restore-cli)
    ///
    /// * [Metadata for Amazon
    ///   DocumentDB](https://docs.aws.amazon.com/aws-backup/latest/devguide/restoring-docdb.html#docdb-restore-cli)
    ///
    /// * [Metadata for
    ///   CloudFormation](https://docs.aws.amazon.com/aws-backup/latest/devguide/restore-application-stacks.html#restoring-cfn-cli)
    ///
    /// * [Metadata for Amazon
    ///   DynamoDB](https://docs.aws.amazon.com/aws-backup/latest/devguide/restoring-dynamodb.html#ddb-restore-cli)
    ///
    /// * [
    /// Metadata for Amazon
    /// EBS](https://docs.aws.amazon.com/aws-backup/latest/devguide/restoring-ebs.html#ebs-restore-cli)
    ///
    /// * [Metadata for Amazon
    ///   EC2](https://docs.aws.amazon.com/aws-backup/latest/devguide/restoring-ec2.html#restoring-ec2-cli)
    ///
    /// * [Metadata for Amazon
    ///   EFS](https://docs.aws.amazon.com/aws-backup/latest/devguide/restoring-efs.html#efs-restore-cli)
    ///
    /// * [Metadata for Amazon
    ///   EKS](https://docs.aws.amazon.com/aws-backup/latest/devguide/restoring-eks.html#eks-restore-backup-section)
    ///
    /// * [Metadata for Amazon
    ///   FSx](https://docs.aws.amazon.com/aws-backup/latest/devguide/restoring-fsx.html#fsx-restore-cli)
    ///
    /// * [Metadata for Amazon
    ///   Neptune](https://docs.aws.amazon.com/aws-backup/latest/devguide/restoring-nep.html#nep-restore-cli)
    ///
    /// * [Metadata for Amazon
    ///   RDS](https://docs.aws.amazon.com/aws-backup/latest/devguide/restoring-rds.html#rds-restore-cli)
    ///
    /// * [Metadata for Amazon
    ///   Redshift](https://docs.aws.amazon.com/aws-backup/latest/devguide/redshift-restores.html#redshift-restore-api)
    ///
    /// * [Metadata for Storage
    ///   Gateway](https://docs.aws.amazon.com/aws-backup/latest/devguide/restoring-storage-gateway.html#restoring-sgw-cli)
    ///
    /// * [Metadata for Amazon
    ///   S3](https://docs.aws.amazon.com/aws-backup/latest/devguide/restoring-s3.html#s3-restore-cli)
    ///
    /// * [Metadata for Amazon
    ///   Timestream](https://docs.aws.amazon.com/aws-backup/latest/devguide/timestream-restore.html#timestream-restore-api)
    ///
    /// * [Metadata for virtual
    ///   machines](https://docs.aws.amazon.com/aws-backup/latest/devguide/restoring-vm.html#vm-restore-cli)
    metadata: []const aws.map.StringMapEntry,

    /// An ARN that uniquely identifies a recovery point; for example,
    /// `arn:aws:backup:us-east-1:123456789012:recovery-point:1EB3B5E7-9EB0-435A-A80B-108B488B0D45`.
    recovery_point_arn: []const u8,

    /// Starts a job to restore a recovery point for one of the following resources:
    ///
    /// * `Aurora` - Amazon Aurora
    ///
    /// * `DocumentDB` - Amazon DocumentDB
    ///
    /// * `CloudFormation` - CloudFormation
    ///
    /// * `DynamoDB` - Amazon DynamoDB
    ///
    /// * `EBS` - Amazon Elastic Block Store
    ///
    /// * `EC2` - Amazon Elastic Compute Cloud
    ///
    /// * `EFS` - Amazon Elastic File System
    ///
    /// * `EKS` - Amazon Elastic Kubernetes Service
    ///
    /// * `FSx` - Amazon FSx
    ///
    /// * `Neptune` - Amazon Neptune
    ///
    /// * `RDS` - Amazon Relational Database Service
    ///
    /// * `Redshift` - Amazon Redshift
    ///
    /// * `Storage Gateway` - Storage Gateway
    ///
    /// * `S3` - Amazon Simple Storage Service
    ///
    /// * `Timestream` - Amazon Timestream
    ///
    /// * `VirtualMachine` - Virtual machines
    resource_type: ?[]const u8 = null,

    pub const json_field_names = .{
        .copy_source_tags_to_restored_resource = "CopySourceTagsToRestoredResource",
        .iam_role_arn = "IamRoleArn",
        .idempotency_token = "IdempotencyToken",
        .metadata = "Metadata",
        .recovery_point_arn = "RecoveryPointArn",
        .resource_type = "ResourceType",
    };
};

pub const StartRestoreJobOutput = struct {
    /// Uniquely identifies the job that restores a recovery point.
    restore_job_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .restore_job_id = "RestoreJobId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartRestoreJobInput, options: CallOptions) !StartRestoreJobOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: StartRestoreJobInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("backup", "Backup", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/restore-jobs";

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.copy_source_tags_to_restored_resource) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"CopySourceTagsToRestoredResource\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.iam_role_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"IamRoleArn\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.idempotency_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"IdempotencyToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Metadata\":");
    try aws.json.writeValue(@TypeOf(input.metadata), input.metadata, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"RecoveryPointArn\":");
    try aws.json.writeValue(@TypeOf(input.recovery_point_arn), input.recovery_point_arn, allocator, &body_buf);
    has_prev = true;
    if (input.resource_type) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ResourceType\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartRestoreJobOutput {
    var result: StartRestoreJobOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(StartRestoreJobOutput, body, allocator);
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
