const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const MediaAnalysisInput = @import("media_analysis_input.zig").MediaAnalysisInput;
const MediaAnalysisOperationsConfig = @import("media_analysis_operations_config.zig").MediaAnalysisOperationsConfig;
const MediaAnalysisOutputConfig = @import("media_analysis_output_config.zig").MediaAnalysisOutputConfig;

pub const StartMediaAnalysisJobInput = struct {
    /// Idempotency token used to prevent the accidental creation of duplicate
    /// versions. If
    /// you use the same token with multiple `StartMediaAnalysisJobRequest`
    /// requests, the same
    /// response is returned. Use `ClientRequestToken` to prevent the same request
    /// from being
    /// processed more than once.
    client_request_token: ?[]const u8 = null,

    /// Input data to be analyzed by the job.
    input: MediaAnalysisInput,

    /// The name of the job. Does not have to be unique.
    job_name: ?[]const u8 = null,

    /// The identifier of customer managed AWS KMS key (name or ARN). The key
    /// is used to encrypt images copied into the service. The key is also used
    /// to encrypt results and manifest files written to the output Amazon S3
    /// bucket.
    kms_key_id: ?[]const u8 = null,

    /// Configuration options for the media analysis job to be created.
    operations_config: MediaAnalysisOperationsConfig,

    /// The Amazon S3 bucket location to store the results.
    output_config: MediaAnalysisOutputConfig,

    pub const json_field_names = .{
        .client_request_token = "ClientRequestToken",
        .input = "Input",
        .job_name = "JobName",
        .kms_key_id = "KmsKeyId",
        .operations_config = "OperationsConfig",
        .output_config = "OutputConfig",
    };
};

pub const StartMediaAnalysisJobOutput = struct {
    /// Identifier for the created job.
    job_id: []const u8,

    pub const json_field_names = .{
        .job_id = "JobId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartMediaAnalysisJobInput, options: CallOptions) !StartMediaAnalysisJobOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: StartMediaAnalysisJobInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "RekognitionService.StartMediaAnalysisJob");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartMediaAnalysisJobOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(StartMediaAnalysisJobOutput, body, allocator);
}
