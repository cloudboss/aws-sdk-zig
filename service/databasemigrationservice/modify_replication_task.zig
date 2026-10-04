const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const MigrationTypeValue = @import("migration_type_value.zig").MigrationTypeValue;
const ReplicationTask = @import("replication_task.zig").ReplicationTask;

pub const ModifyReplicationTaskInput = struct {
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

    /// The migration type. Valid values: `full-load` | `cdc` |
    /// `full-load-and-cdc`
    migration_type: ?MigrationTypeValue = null,

    /// The Amazon Resource Name (ARN) of the replication task.
    replication_task_arn: []const u8,

    /// The replication task identifier.
    ///
    /// Constraints:
    ///
    /// * Must contain 1-255 alphanumeric characters or hyphens.
    ///
    /// * First character must be a letter.
    ///
    /// * Cannot end with a hyphen or contain two consecutive hyphens.
    replication_task_identifier: ?[]const u8 = null,

    /// JSON file that contains settings for the task, such as task metadata
    /// settings.
    replication_task_settings: ?[]const u8 = null,

    /// When using the CLI or boto3, provide the path of the JSON file that contains
    /// the table
    /// mappings. Precede the path with `file://`. For example, `--table-mappings
    /// file://mappingfile.json`. When working with the DMS API, provide the JSON as
    /// the
    /// parameter value.
    table_mappings: ?[]const u8 = null,

    /// Supplemental information that the task requires to migrate the data for
    /// certain source
    /// and target endpoints. For more information, see [Specifying Supplemental
    /// Data for
    /// Task
    /// Settings](https://docs.aws.amazon.com/dms/latest/userguide/CHAP_Tasks.TaskData.html) in the *Database Migration Service User Guide.*
    task_data: ?[]const u8 = null,

    pub const json_field_names = .{
        .cdc_start_position = "CdcStartPosition",
        .cdc_start_time = "CdcStartTime",
        .cdc_stop_position = "CdcStopPosition",
        .migration_type = "MigrationType",
        .replication_task_arn = "ReplicationTaskArn",
        .replication_task_identifier = "ReplicationTaskIdentifier",
        .replication_task_settings = "ReplicationTaskSettings",
        .table_mappings = "TableMappings",
        .task_data = "TaskData",
    };
};

pub const ModifyReplicationTaskOutput = struct {
    /// The replication task that was modified.
    replication_task: ?ReplicationTask = null,

    pub const json_field_names = .{
        .replication_task = "ReplicationTask",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ModifyReplicationTaskInput, options: CallOptions) !ModifyReplicationTaskOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ModifyReplicationTaskInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AmazonDMSv20160101.ModifyReplicationTask");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ModifyReplicationTaskOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ModifyReplicationTaskOutput, body, allocator);
}
