const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const EarthObservationJobErrorDetails = @import("earth_observation_job_error_details.zig").EarthObservationJobErrorDetails;
const ExportErrorDetails = @import("export_error_details.zig").ExportErrorDetails;
const EarthObservationJobExportStatus = @import("earth_observation_job_export_status.zig").EarthObservationJobExportStatus;
const InputConfigOutput = @import("input_config_output.zig").InputConfigOutput;
const JobConfigInput = @import("job_config_input.zig").JobConfigInput;
const OutputBand = @import("output_band.zig").OutputBand;
const EarthObservationJobStatus = @import("earth_observation_job_status.zig").EarthObservationJobStatus;

pub const GetEarthObservationJobInput = struct {
    /// The Amazon Resource Name (ARN) of the Earth Observation job.
    arn: []const u8,

    pub const json_field_names = .{
        .arn = "Arn",
    };
};

pub const GetEarthObservationJobOutput = struct {
    /// The Amazon Resource Name (ARN) of the Earth Observation job.
    arn: []const u8,

    /// The creation time of the initiated Earth Observation job.
    creation_time: i64,

    /// The duration of Earth Observation job, in seconds.
    duration_in_seconds: i32,

    /// Details about the errors generated during the Earth Observation job.
    error_details: ?EarthObservationJobErrorDetails = null,

    /// The Amazon Resource Name (ARN) of the IAM role that you specified for the
    /// job.
    execution_role_arn: ?[]const u8 = null,

    /// Details about the errors generated during ExportEarthObservationJob.
    export_error_details: ?ExportErrorDetails = null,

    /// The status of the Earth Observation job.
    export_status: ?EarthObservationJobExportStatus = null,

    /// Input data for the Earth Observation job.
    input_config: ?InputConfigOutput = null,

    /// An object containing information about the job configuration.
    job_config: ?JobConfigInput = null,

    /// The Key Management Service key ID for server-side encryption.
    kms_key_id: ?[]const u8 = null,

    /// The name of the Earth Observation job.
    name: []const u8,

    /// Bands available in the output of an operation.
    output_bands: ?[]const OutputBand = null,

    /// The status of a previously initiated Earth Observation job.
    status: EarthObservationJobStatus,

    /// Each tag consists of a key and a value.
    tags: ?[]const aws.map.StringMapEntry = null,

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
        .output_bands = "OutputBands",
        .status = "Status",
        .tags = "Tags",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetEarthObservationJobInput, options: CallOptions) !GetEarthObservationJobOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetEarthObservationJobInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("sagemaker-geospatial", "SageMaker Geospatial", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/earth-observation-jobs/");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetEarthObservationJobOutput {
    const result: GetEarthObservationJobOutput = try aws.json.parseJsonObject(
        GetEarthObservationJobOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
