const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const StartReplicationTaskTypeValue = @import("start_replication_task_type_value.zig").StartReplicationTaskTypeValue;
const ReplicationTask = @import("replication_task.zig").ReplicationTask;

pub const StartReplicationTaskInput = struct {
    /// Indicates when you want a change data capture (CDC) operation to start. Use
    /// either
    /// CdcStartPosition or CdcStartTime to specify when you want a CDC operation to
    /// start.
    /// Specifying both values results in an error.
    ///
    /// The value can be in date, checkpoint, or LSN/SCN format.
    ///
    /// Date Example: --cdc-start-position “2018-03-08T12:12:12”
    ///
    /// Checkpoint Example: --cdc-start-position
    /// "checkpoint:V1#27#mysql-bin-changelog.157832:1975:-1:2002:677883278264080:mysql-bin-changelog.157832:1876#0#0#*#0#93"
    ///
    /// LSN Example: --cdc-start-position “mysql-bin-changelog.000024:373”
    ///
    /// When you use this task setting with a source PostgreSQL database, a logical
    /// replication slot should already be created and associated with the source
    /// endpoint. You
    /// can verify this by setting the `slotName` extra connection attribute to the
    /// name of this logical replication slot. For more information, see [Extra
    /// Connection Attributes When Using PostgreSQL as a Source
    /// for
    /// DMS](https://docs.aws.amazon.com/dms/latest/userguide/CHAP_Source.PostgreSQL.html#CHAP_Source.PostgreSQL.ConnectionAttrib).
    cdc_start_position: ?[]const u8 = null,

    /// Indicates the start time for a change data capture (CDC) operation. Use
    /// either
    /// CdcStartTime or CdcStartPosition to specify when you want a CDC operation to
    /// start.
    /// Specifying both values results in an error.
    ///
    /// Timestamp Example: --cdc-start-time “2018-03-08T12:12:12”
    cdc_start_time: ?i64 = null,

    /// Indicates when you want a change data capture (CDC) operation to stop. The
    /// value can be
    /// either server time or commit time.
    ///
    /// Server time example: --cdc-stop-position “server_time:2018-02-09T12:12:12”
    ///
    /// Commit time example: --cdc-stop-position “commit_time:2018-02-09T12:12:12“
    cdc_stop_position: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the replication task to be started.
    replication_task_arn: []const u8,

    /// The type of replication task to start.
    ///
    /// `start-replication` is the only valid action that can be used for the first
    /// time a task with the migration type of `full-load`full-load,
    /// `full-load-and-cdc` or `cdc` is run. Any other action used for the first
    /// time on a given task, such as `resume-processing` and reload-target will
    /// result in data errors.
    ///
    /// You can also use ReloadTables to reload specific tables that failed during
    /// migration instead of restarting the task.
    ///
    /// For a `full-load` task, the resume-processing option will reload any tables
    /// that were partially loaded or not yet loaded during the full load phase.
    ///
    /// For a `full-load-and-cdc` task, DMS migrates table data, and then applies
    /// data changes that occur on the source. To load all the tables again, and
    /// start capturing source changes, use `reload-target`. Otherwise use
    /// `resume-processing`, to replicate the changes from the last stop position.
    ///
    /// For a `cdc` only task, to start from a specific position, you must use
    /// start-replication and also specify the start position. Check the source
    /// endpoint DMS documentation for any limitations. For example, not all sources
    /// support starting from a time.
    ///
    /// `resume-processing` is only available for previously executed tasks.
    start_replication_task_type: StartReplicationTaskTypeValue,

    pub const json_field_names = .{
        .cdc_start_position = "CdcStartPosition",
        .cdc_start_time = "CdcStartTime",
        .cdc_stop_position = "CdcStopPosition",
        .replication_task_arn = "ReplicationTaskArn",
        .start_replication_task_type = "StartReplicationTaskType",
    };
};

pub const StartReplicationTaskOutput = struct {
    /// The replication task started.
    replication_task: ?ReplicationTask = null,

    pub const json_field_names = .{
        .replication_task = "ReplicationTask",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartReplicationTaskInput, options: Options) !StartReplicationTaskOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "databasemigrationservice");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(response.body, response.status, response.headers, allocator);
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: StartReplicationTaskInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("databasemigrationservice", "Database Migration Service", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(alloc, "X-Amz-Target", "AmazonDMSv20160101.StartReplicationTask");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !StartReplicationTaskOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(StartReplicationTaskOutput, body, alloc);
}

fn parseErrorResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(alloc);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "AccessDeniedFault")) {
        return .{ .arena = arena, .kind = .{ .access_denied_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CollectorNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .collector_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "FailedDependencyFault")) {
        return .{ .arena = arena, .kind = .{ .failed_dependency_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InsufficientResourceCapacityFault")) {
        return .{ .arena = arena, .kind = .{ .insufficient_resource_capacity_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidCertificateFault")) {
        return .{ .arena = arena, .kind = .{ .invalid_certificate_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidOperationFault")) {
        return .{ .arena = arena, .kind = .{ .invalid_operation_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidResourceStateFault")) {
        return .{ .arena = arena, .kind = .{ .invalid_resource_state_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidSubnet")) {
        return .{ .arena = arena, .kind = .{ .invalid_subnet = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "KMSAccessDeniedFault")) {
        return .{ .arena = arena, .kind = .{ .kms_access_denied_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "KMSDisabledFault")) {
        return .{ .arena = arena, .kind = .{ .kms_disabled_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "KMSFault")) {
        return .{ .arena = arena, .kind = .{ .kms_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "KMSInvalidStateFault")) {
        return .{ .arena = arena, .kind = .{ .kms_invalid_state_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "KMSKeyNotAccessibleFault")) {
        return .{ .arena = arena, .kind = .{ .kms_key_not_accessible_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "KMSNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .kms_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "KMSThrottlingFault")) {
        return .{ .arena = arena, .kind = .{ .kms_throttling_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ReplicationSubnetGroupDoesNotCoverEnoughAZs")) {
        return .{ .arena = arena, .kind = .{ .replication_subnet_group_does_not_cover_enough_a_zs = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceAlreadyExistsFault")) {
        return .{ .arena = arena, .kind = .{ .resource_already_exists_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceQuotaExceededFault")) {
        return .{ .arena = arena, .kind = .{ .resource_quota_exceeded_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "S3AccessDeniedFault")) {
        return .{ .arena = arena, .kind = .{ .s3_access_denied_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "S3ResourceNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .s3_resource_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "SNSInvalidTopicFault")) {
        return .{ .arena = arena, .kind = .{ .sns_invalid_topic_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "SNSNoAuthorizationFault")) {
        return .{ .arena = arena, .kind = .{ .sns_no_authorization_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "StorageQuotaExceededFault")) {
        return .{ .arena = arena, .kind = .{ .storage_quota_exceeded_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "SubnetAlreadyInUse")) {
        return .{ .arena = arena, .kind = .{ .subnet_already_in_use = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UpgradeDependencyFailureFault")) {
        return .{ .arena = arena, .kind = .{ .upgrade_dependency_failure_fault = .{
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
