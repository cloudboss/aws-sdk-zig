const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartReplicationTaskInput, options: CallOptions) !StartReplicationTaskOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "dms", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: StartReplicationTaskInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("dms", "Database Migration Service", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AmazonDMSv20160101.StartReplicationTask");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartReplicationTaskOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(StartReplicationTaskOutput, body, allocator);
}
