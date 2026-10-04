const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Filter = @import("filter.zig").Filter;
const ReplicationTaskAssessmentRun = @import("replication_task_assessment_run.zig").ReplicationTaskAssessmentRun;

pub const DescribeReplicationTaskAssessmentRunsInput = struct {
    /// Filters applied to the premigration assessment runs described in the form of
    /// key-value
    /// pairs.
    ///
    /// Valid filter names: `replication-task-assessment-run-arn`,
    /// `replication-task-arn`, `replication-instance-arn`,
    /// `status`
    filters: ?[]const Filter = null,

    /// An optional pagination token provided by a previous request. If this
    /// parameter is
    /// specified, the response includes only records beyond the marker, up to the
    /// value specified
    /// by `MaxRecords`.
    marker: ?[]const u8 = null,

    /// The maximum number of records to include in the response. If more records
    /// exist than the
    /// specified `MaxRecords` value, a pagination token called a marker is included
    /// in
    /// the response so that the remaining results can be retrieved.
    max_records: ?i32 = null,

    pub const json_field_names = .{
        .filters = "Filters",
        .marker = "Marker",
        .max_records = "MaxRecords",
    };
};

pub const DescribeReplicationTaskAssessmentRunsOutput = struct {
    /// A pagination token returned for you to pass to a subsequent request. If you
    /// pass this
    /// token as the `Marker` value in a subsequent request, the response includes
    /// only
    /// records beyond the marker, up to the value specified in the request by
    /// `MaxRecords`.
    marker: ?[]const u8 = null,

    /// One or more premigration assessment runs as specified by `Filters`.
    replication_task_assessment_runs: ?[]const ReplicationTaskAssessmentRun = null,

    pub const json_field_names = .{
        .marker = "Marker",
        .replication_task_assessment_runs = "ReplicationTaskAssessmentRuns",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeReplicationTaskAssessmentRunsInput, options: CallOptions) !DescribeReplicationTaskAssessmentRunsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeReplicationTaskAssessmentRunsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AmazonDMSv20160101.DescribeReplicationTaskAssessmentRuns");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeReplicationTaskAssessmentRunsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeReplicationTaskAssessmentRunsOutput, body, allocator);
}
