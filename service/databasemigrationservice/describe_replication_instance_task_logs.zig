const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ReplicationInstanceTaskLog = @import("replication_instance_task_log.zig").ReplicationInstanceTaskLog;

pub const DescribeReplicationInstanceTaskLogsInput = struct {
    /// An optional pagination token provided by a previous request. If this
    /// parameter is
    /// specified, the response includes only records beyond the marker, up to the
    /// value specified
    /// by `MaxRecords`.
    marker: ?[]const u8 = null,

    /// The maximum number of records to include in the response. If more records
    /// exist than
    /// the specified `MaxRecords` value, a pagination token called a marker is
    /// included
    /// in the response so that the remaining results can be retrieved.
    ///
    /// Default: 100
    ///
    /// Constraints: Minimum 20, maximum 100.
    max_records: ?i32 = null,

    /// The Amazon Resource Name (ARN) of the replication instance.
    replication_instance_arn: []const u8,

    pub const json_field_names = .{
        .marker = "Marker",
        .max_records = "MaxRecords",
        .replication_instance_arn = "ReplicationInstanceArn",
    };
};

pub const DescribeReplicationInstanceTaskLogsOutput = struct {
    /// An optional pagination token provided by a previous request. If this
    /// parameter is
    /// specified, the response includes only records beyond the marker, up to the
    /// value specified
    /// by `MaxRecords`.
    marker: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the replication instance.
    replication_instance_arn: ?[]const u8 = null,

    /// An array of replication task log metadata. Each member of the array contains
    /// the
    /// replication task name, ARN, and task log size (in bytes).
    replication_instance_task_logs: ?[]const ReplicationInstanceTaskLog = null,

    pub const json_field_names = .{
        .marker = "Marker",
        .replication_instance_arn = "ReplicationInstanceArn",
        .replication_instance_task_logs = "ReplicationInstanceTaskLogs",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeReplicationInstanceTaskLogsInput, options: CallOptions) !DescribeReplicationInstanceTaskLogsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeReplicationInstanceTaskLogsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AmazonDMSv20160101.DescribeReplicationInstanceTaskLogs");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeReplicationInstanceTaskLogsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeReplicationInstanceTaskLogsOutput, body, allocator);
}
