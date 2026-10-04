const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const MediaAnalysisJobFailureDetails = @import("media_analysis_job_failure_details.zig").MediaAnalysisJobFailureDetails;
const MediaAnalysisInput = @import("media_analysis_input.zig").MediaAnalysisInput;
const MediaAnalysisManifestSummary = @import("media_analysis_manifest_summary.zig").MediaAnalysisManifestSummary;
const MediaAnalysisOperationsConfig = @import("media_analysis_operations_config.zig").MediaAnalysisOperationsConfig;
const MediaAnalysisOutputConfig = @import("media_analysis_output_config.zig").MediaAnalysisOutputConfig;
const MediaAnalysisResults = @import("media_analysis_results.zig").MediaAnalysisResults;
const MediaAnalysisJobStatus = @import("media_analysis_job_status.zig").MediaAnalysisJobStatus;

pub const GetMediaAnalysisJobInput = struct {
    /// Unique identifier for the media analysis job for which you want to retrieve
    /// results.
    job_id: []const u8,

    pub const json_field_names = .{
        .job_id = "JobId",
    };
};

pub const GetMediaAnalysisJobOutput = struct {
    /// The Unix date and time when the job finished.
    completion_timestamp: ?i64 = null,

    /// The Unix date and time when the job was started.
    creation_timestamp: i64,

    /// Details about the error that resulted in failure of the job.
    failure_details: ?MediaAnalysisJobFailureDetails = null,

    /// Reference to the input manifest that was provided in the job creation
    /// request.
    input: ?MediaAnalysisInput = null,

    /// The identifier for the media analysis job.
    job_id: []const u8,

    /// The name of the media analysis job.
    job_name: ?[]const u8 = null,

    /// KMS Key that was provided in the creation request.
    kms_key_id: ?[]const u8 = null,

    /// The summary manifest provides statistics on input manifest and errors
    /// identified in the input manifest.
    manifest_summary: ?MediaAnalysisManifestSummary = null,

    /// Operation configurations that were provided during job creation.
    operations_config: ?MediaAnalysisOperationsConfig = null,

    /// Output configuration that was provided in the creation request.
    output_config: ?MediaAnalysisOutputConfig = null,

    /// Output manifest that contains prediction results.
    results: ?MediaAnalysisResults = null,

    /// The current status of the media analysis job.
    status: MediaAnalysisJobStatus,

    pub const json_field_names = .{
        .completion_timestamp = "CompletionTimestamp",
        .creation_timestamp = "CreationTimestamp",
        .failure_details = "FailureDetails",
        .input = "Input",
        .job_id = "JobId",
        .job_name = "JobName",
        .kms_key_id = "KmsKeyId",
        .manifest_summary = "ManifestSummary",
        .operations_config = "OperationsConfig",
        .output_config = "OutputConfig",
        .results = "Results",
        .status = "Status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetMediaAnalysisJobInput, options: CallOptions) !GetMediaAnalysisJobOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "rekognition", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetMediaAnalysisJobInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("rekognition", "Rekognition", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "RekognitionService.GetMediaAnalysisJob");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetMediaAnalysisJobOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(GetMediaAnalysisJobOutput, body, allocator);
}
