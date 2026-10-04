const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Tag = @import("tag.zig").Tag;
const ReplicationTaskAssessmentRun = @import("replication_task_assessment_run.zig").ReplicationTaskAssessmentRun;

pub const StartReplicationTaskAssessmentRunInput = struct {
    /// Unique name to identify the assessment run.
    assessment_run_name: []const u8,

    /// Space-separated list of names for specific individual assessments that you
    /// want to
    /// exclude. These names come from the default list of individual assessments
    /// that DMS
    /// supports for the associated migration task. This task is specified by
    /// `ReplicationTaskArn`.
    ///
    /// You can't set a value for `Exclude` if you also set a value for
    /// `IncludeOnly` in the API operation.
    ///
    /// To identify the names of the default individual assessments that DMS
    /// supports for
    /// the associated migration task, run the
    /// `DescribeApplicableIndividualAssessments` operation using its own
    /// `ReplicationTaskArn` request parameter.
    exclude: ?[]const []const u8 = null,

    /// Space-separated list of names for specific individual assessments that you
    /// want to
    /// include. These names come from the default list of individual assessments
    /// that DMS
    /// supports for the associated migration task. This task is specified by
    /// `ReplicationTaskArn`.
    ///
    /// You can't set a value for `IncludeOnly` if you also set a value for
    /// `Exclude` in the API operation.
    ///
    /// To identify the names of the default individual assessments that DMS
    /// supports for
    /// the associated migration task, run the
    /// `DescribeApplicableIndividualAssessments` operation using its own
    /// `ReplicationTaskArn` request parameter.
    include_only: ?[]const []const u8 = null,

    /// Amazon Resource Name (ARN) of the migration task associated with the
    /// premigration
    /// assessment run that you want to start.
    replication_task_arn: []const u8,

    /// Encryption mode that you can specify to encrypt the results of this
    /// assessment run. If
    /// you don't specify this request parameter, DMS stores the assessment run
    /// results
    /// without encryption. You can specify one of the options following:
    ///
    /// * `"SSE_S3"` – The server-side encryption provided as a default by
    /// Amazon S3.
    ///
    /// * `"SSE_KMS"` – Key Management Service (KMS) encryption. This encryption can
    /// use either a custom KMS encryption key that you specify or the default KMS
    /// encryption
    /// key that DMS provides.
    result_encryption_mode: ?[]const u8 = null,

    /// ARN of a custom KMS encryption key that you specify when you set
    /// `ResultEncryptionMode` to `"SSE_KMS`".
    result_kms_key_arn: ?[]const u8 = null,

    /// Amazon S3 bucket where you want DMS to store the results of this assessment
    /// run.
    result_location_bucket: []const u8,

    /// Folder within an Amazon S3 bucket where you want DMS to store the results of
    /// this
    /// assessment run.
    result_location_folder: ?[]const u8 = null,

    /// ARN of the service role needed to start the assessment run. The role must
    /// allow the
    /// `iam:PassRole` action.
    service_access_role_arn: []const u8,

    /// One or more tags to be assigned to the premigration assessment run that you
    /// want to
    /// start.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .assessment_run_name = "AssessmentRunName",
        .exclude = "Exclude",
        .include_only = "IncludeOnly",
        .replication_task_arn = "ReplicationTaskArn",
        .result_encryption_mode = "ResultEncryptionMode",
        .result_kms_key_arn = "ResultKmsKeyArn",
        .result_location_bucket = "ResultLocationBucket",
        .result_location_folder = "ResultLocationFolder",
        .service_access_role_arn = "ServiceAccessRoleArn",
        .tags = "Tags",
    };
};

pub const StartReplicationTaskAssessmentRunOutput = struct {
    /// The premigration assessment run that was started.
    replication_task_assessment_run: ?ReplicationTaskAssessmentRun = null,

    pub const json_field_names = .{
        .replication_task_assessment_run = "ReplicationTaskAssessmentRun",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartReplicationTaskAssessmentRunInput, options: CallOptions) !StartReplicationTaskAssessmentRunOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: StartReplicationTaskAssessmentRunInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AmazonDMSv20160101.StartReplicationTaskAssessmentRun");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartReplicationTaskAssessmentRunOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(StartReplicationTaskAssessmentRunOutput, body, allocator);
}
