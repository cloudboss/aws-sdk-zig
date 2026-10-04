const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const VectorEnrichmentJobErrorDetails = @import("vector_enrichment_job_error_details.zig").VectorEnrichmentJobErrorDetails;
const VectorEnrichmentJobExportErrorDetails = @import("vector_enrichment_job_export_error_details.zig").VectorEnrichmentJobExportErrorDetails;
const VectorEnrichmentJobExportStatus = @import("vector_enrichment_job_export_status.zig").VectorEnrichmentJobExportStatus;
const VectorEnrichmentJobInputConfig = @import("vector_enrichment_job_input_config.zig").VectorEnrichmentJobInputConfig;
const VectorEnrichmentJobConfig = @import("vector_enrichment_job_config.zig").VectorEnrichmentJobConfig;
const VectorEnrichmentJobStatus = @import("vector_enrichment_job_status.zig").VectorEnrichmentJobStatus;
const VectorEnrichmentJobType = @import("vector_enrichment_job_type.zig").VectorEnrichmentJobType;

pub const GetVectorEnrichmentJobInput = struct {
    /// The Amazon Resource Name (ARN) of the Vector Enrichment job.
    arn: []const u8,

    pub const json_field_names = .{
        .arn = "Arn",
    };
};

pub const GetVectorEnrichmentJobOutput = struct {
    /// The Amazon Resource Name (ARN) of the Vector Enrichment job.
    arn: []const u8,

    /// The creation time.
    creation_time: i64,

    /// The duration of the Vector Enrichment job, in seconds.
    duration_in_seconds: i32,

    /// Details about the errors generated during the Vector Enrichment job.
    error_details: ?VectorEnrichmentJobErrorDetails = null,

    /// The Amazon Resource Name (ARN) of the IAM role that you specified for the
    /// job.
    execution_role_arn: []const u8,

    /// Details about the errors generated during the ExportVectorEnrichmentJob.
    export_error_details: ?VectorEnrichmentJobExportErrorDetails = null,

    /// The export status of the Vector Enrichment job being initiated.
    export_status: ?VectorEnrichmentJobExportStatus = null,

    /// Input configuration information for the Vector Enrichment job.
    input_config: ?VectorEnrichmentJobInputConfig = null,

    /// An object containing information about the job configuration.
    job_config: ?VectorEnrichmentJobConfig = null,

    /// The Key Management Service key ID for server-side encryption.
    kms_key_id: ?[]const u8 = null,

    /// The name of the Vector Enrichment job.
    name: []const u8,

    /// The status of the initiated Vector Enrichment job.
    status: VectorEnrichmentJobStatus,

    /// Each tag consists of a key and a value.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The type of the Vector Enrichment job being initiated.
    @"type": VectorEnrichmentJobType,

    pub const json_field_names = .{
        .arn = "Arn",
        .creation_time = "CreationTime",
        .duration_in_seconds = "DurationInSeconds",
        .error_details = "ErrorDetails",
        .execution_role_arn = "ExecutionRoleArn",
        .export_error_details = "ExportErrorDetails",
        .export_status = "ExportStatus",
        .input_config = "InputConfig",
        .job_config = "JobConfig",
        .kms_key_id = "KmsKeyId",
        .name = "Name",
        .status = "Status",
        .tags = "Tags",
        .@"type" = "Type",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetVectorEnrichmentJobInput, options: CallOptions) !GetVectorEnrichmentJobOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "sagemaker-geospatial", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetVectorEnrichmentJobInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("sagemaker-geospatial", "SageMaker Geospatial", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/vector-enrichment-jobs/");
    try path_buf.appendSlice(allocator, input.arn);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetVectorEnrichmentJobOutput {
    var result: GetVectorEnrichmentJobOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetVectorEnrichmentJobOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
