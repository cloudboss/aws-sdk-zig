const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const MigrationTypeValue = @import("migration_type_value.zig").MigrationTypeValue;

pub const DescribeApplicableIndividualAssessmentsInput = struct {
    /// Optional pagination token provided by a previous request. If this parameter
    /// is
    /// specified, the response includes only records beyond the marker, up to the
    /// value specified
    /// by `MaxRecords`.
    marker: ?[]const u8 = null,

    /// Maximum number of records to include in the response. If more records exist
    /// than the
    /// specified `MaxRecords` value, a pagination token called a marker is included
    /// in
    /// the response so that the remaining results can be retrieved.
    max_records: ?i32 = null,

    /// Name of the migration type that each provided individual assessment must
    /// support.
    migration_type: ?MigrationTypeValue = null,

    /// Amazon Resource Name (ARN) of a serverless replication on which you want to
    /// base the default
    /// list of individual assessments.
    replication_config_arn: ?[]const u8 = null,

    /// ARN of a replication instance on which you want to base the default list of
    /// individual
    /// assessments.
    replication_instance_arn: ?[]const u8 = null,

    /// Amazon Resource Name (ARN) of a migration task on which you want to base the
    /// default
    /// list of individual assessments.
    replication_task_arn: ?[]const u8 = null,

    /// Name of a database engine that the specified replication instance supports
    /// as a
    /// source.
    source_engine_name: ?[]const u8 = null,

    /// Name of a database engine that the specified replication instance supports
    /// as a
    /// target.
    target_engine_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .marker = "Marker",
        .max_records = "MaxRecords",
        .migration_type = "MigrationType",
        .replication_config_arn = "ReplicationConfigArn",
        .replication_instance_arn = "ReplicationInstanceArn",
        .replication_task_arn = "ReplicationTaskArn",
        .source_engine_name = "SourceEngineName",
        .target_engine_name = "TargetEngineName",
    };
};

pub const DescribeApplicableIndividualAssessmentsOutput = struct {
    /// List of names for the individual assessments supported by the premigration
    /// assessment
    /// run that you start based on the specified request parameters. For more
    /// information on the
    /// available individual assessments, including compatibility with different
    /// migration task
    /// configurations, see [Working with premigration assessment
    /// runs](https://docs.aws.amazon.com/dms/latest/userguide/CHAP_Tasks.AssessmentReport.html) in the
    /// *Database Migration Service User Guide.*
    individual_assessment_names: ?[]const []const u8 = null,

    /// Pagination token returned for you to pass to a subsequent request. If you
    /// pass this
    /// token as the `Marker` value in a subsequent request, the response includes
    /// only
    /// records beyond the marker, up to the value specified in the request by
    /// `MaxRecords`.
    marker: ?[]const u8 = null,

    pub const json_field_names = .{
        .individual_assessment_names = "IndividualAssessmentNames",
        .marker = "Marker",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeApplicableIndividualAssessmentsInput, options: CallOptions) !DescribeApplicableIndividualAssessmentsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeApplicableIndividualAssessmentsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AmazonDMSv20160101.DescribeApplicableIndividualAssessments");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeApplicableIndividualAssessmentsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeApplicableIndividualAssessmentsOutput, body, allocator);
}
