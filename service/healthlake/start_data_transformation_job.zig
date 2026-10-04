const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const TransformationInputDataConfig = @import("transformation_input_data_config.zig").TransformationInputDataConfig;
const TransformationOutputDataConfig = @import("transformation_output_data_config.zig").TransformationOutputDataConfig;
const TransformationJobStatus = @import("transformation_job_status.zig").TransformationJobStatus;

pub const StartDataTransformationJobInput = struct {
    /// A unique, case-sensitive identifier to ensure that the operation completes
    /// no more than one time. If this token matches a previous request, the service
    /// ignores the request but does not return an error.
    client_token: []const u8,

    /// The Amazon Resource Name (ARN) of the Amazon Web Services Identity and
    /// Access Management (IAM) role that HealthLake assumes to read from and write
    /// to the specified Amazon S3 locations.
    data_access_role_arn: []const u8,

    /// Specifies whether drift detection is enabled for this job. When enabled,
    /// HealthLake writes a drift report to the output Amazon S3 location alongside
    /// the converted files.
    drift_detection_enabled: ?bool = null,

    /// The Amazon S3 location and format of the source files to transform.
    input_data_config: TransformationInputDataConfig,

    /// A descriptive name for the data transformation job.
    job_name: ?[]const u8 = null,

    /// The Amazon S3 output location and Amazon Web Services Key Management Service
    /// (Amazon Web Services KMS) encryption configuration.
    output_data_config: TransformationOutputDataConfig,

    /// The unique identifier of the data transformation profile to use for
    /// conversion.
    profile_id: []const u8,

    /// Specifies whether FHIR R4 Provenance resource generation is enabled for this
    /// transformation job. When provenance is enabled, the service also generates
    /// related DocumentReference and Device resources. If you don't specify a
    /// value, the default is `true`. To disable provenance output, set this
    /// parameter to `false`.
    provenance_enabled: ?bool = null,

    pub const json_field_names = .{
        .client_token = "ClientToken",
        .data_access_role_arn = "DataAccessRoleArn",
        .drift_detection_enabled = "DriftDetectionEnabled",
        .input_data_config = "InputDataConfig",
        .job_name = "JobName",
        .output_data_config = "OutputDataConfig",
        .profile_id = "ProfileId",
        .provenance_enabled = "ProvenanceEnabled",
    };
};

pub const StartDataTransformationJobOutput = struct {
    /// The unique identifier assigned to the data transformation job.
    job_id: []const u8,

    /// The initial status of the data transformation job.
    job_status: TransformationJobStatus,

    pub const json_field_names = .{
        .job_id = "JobId",
        .job_status = "JobStatus",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartDataTransformationJobInput, options: CallOptions) !StartDataTransformationJobOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "healthlake", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: StartDataTransformationJobInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("healthlake", "HealthLake", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "HealthLake.StartDataTransformationJob");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartDataTransformationJobOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(StartDataTransformationJobOutput, body, allocator);
}
