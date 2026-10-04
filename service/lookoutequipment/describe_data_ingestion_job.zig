const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DataQualitySummary = @import("data_quality_summary.zig").DataQualitySummary;
const IngestedFilesSummary = @import("ingested_files_summary.zig").IngestedFilesSummary;
const IngestionInputConfiguration = @import("ingestion_input_configuration.zig").IngestionInputConfiguration;
const IngestionJobStatus = @import("ingestion_job_status.zig").IngestionJobStatus;

pub const DescribeDataIngestionJobInput = struct {
    /// The job ID of the data ingestion job.
    job_id: []const u8,

    pub const json_field_names = .{
        .job_id = "JobId",
    };
};

pub const DescribeDataIngestionJobOutput = struct {
    /// The time at which the data ingestion job was created.
    created_at: ?i64 = null,

    /// Indicates the latest timestamp corresponding to data that was successfully
    /// ingested
    /// during this specific ingestion job.
    data_end_time: ?i64 = null,

    /// Gives statistics about a completed ingestion job. These statistics primarily
    /// relate to
    /// quantifying incorrect data such as MissingCompleteSensorData,
    /// MissingSensorData,
    /// UnsupportedDateFormats, InsufficientSensorData, and DuplicateTimeStamps.
    data_quality_summary: ?DataQualitySummary = null,

    /// The Amazon Resource Name (ARN) of the dataset being used in the data
    /// ingestion job.
    dataset_arn: ?[]const u8 = null,

    /// Indicates the earliest timestamp corresponding to data that was successfully
    /// ingested
    /// during this specific ingestion job.
    data_start_time: ?i64 = null,

    /// Specifies the reason for failure when a data ingestion job has failed.
    failed_reason: ?[]const u8 = null,

    /// Indicates the size of the ingested dataset.
    ingested_data_size: ?i64 = null,

    ingested_files_summary: ?IngestedFilesSummary = null,

    /// Specifies the S3 location configuration for the data input for the data
    /// ingestion job.
    ingestion_input_configuration: ?IngestionInputConfiguration = null,

    /// Indicates the job ID of the data ingestion job.
    job_id: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of an IAM role with permission to access the
    /// data source
    /// being ingested.
    role_arn: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the source dataset from which the data
    /// used for the
    /// data ingestion job was imported from.
    source_dataset_arn: ?[]const u8 = null,

    /// Indicates the status of the `DataIngestionJob` operation.
    status: ?IngestionJobStatus = null,

    /// Provides details about status of the ingestion job that is currently in
    /// progress.
    status_detail: ?[]const u8 = null,

    pub const json_field_names = .{
        .created_at = "CreatedAt",
        .data_end_time = "DataEndTime",
        .data_quality_summary = "DataQualitySummary",
        .dataset_arn = "DatasetArn",
        .data_start_time = "DataStartTime",
        .failed_reason = "FailedReason",
        .ingested_data_size = "IngestedDataSize",
        .ingested_files_summary = "IngestedFilesSummary",
        .ingestion_input_configuration = "IngestionInputConfiguration",
        .job_id = "JobId",
        .role_arn = "RoleArn",
        .source_dataset_arn = "SourceDatasetArn",
        .status = "Status",
        .status_detail = "StatusDetail",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeDataIngestionJobInput, options: CallOptions) !DescribeDataIngestionJobOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "lookoutequipment", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeDataIngestionJobInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("lookoutequipment", "LookoutEquipment", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "AWSLookoutEquipmentFrontendService.DescribeDataIngestionJob");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeDataIngestionJobOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeDataIngestionJobOutput, body, allocator);
}
