const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const DataQualitySummary = @import("data_quality_summary.zig").DataQualitySummary;
const IngestedFilesSummary = @import("ingested_files_summary.zig").IngestedFilesSummary;
const IngestionInputConfiguration = @import("ingestion_input_configuration.zig").IngestionInputConfiguration;
const DatasetStatus = @import("dataset_status.zig").DatasetStatus;

pub const DescribeDatasetInput = struct {
    /// The name of the dataset to be described.
    dataset_name: []const u8,

    pub const json_field_names = .{
        .dataset_name = "DatasetName",
    };
};

pub const DescribeDatasetOutput = struct {
    /// Specifies the time the dataset was created in Lookout for Equipment.
    created_at: ?i64 = null,

    /// Indicates the latest timestamp corresponding to data that was successfully
    /// ingested
    /// during the most recent ingestion of this particular dataset.
    data_end_time: ?i64 = null,

    /// Gives statistics associated with the given dataset for the latest successful
    /// associated
    /// ingestion job id. These statistics primarily relate to quantifying incorrect
    /// data such as
    /// MissingCompleteSensorData, MissingSensorData, UnsupportedDateFormats,
    /// InsufficientSensorData, and DuplicateTimeStamps.
    data_quality_summary: ?DataQualitySummary = null,

    /// The Amazon Resource Name (ARN) of the dataset being described.
    dataset_arn: ?[]const u8 = null,

    /// The name of the dataset being described.
    dataset_name: ?[]const u8 = null,

    /// Indicates the earliest timestamp corresponding to data that was successfully
    /// ingested
    /// during the most recent ingestion of this particular dataset.
    data_start_time: ?i64 = null,

    /// IngestedFilesSummary associated with the given dataset for the latest
    /// successful
    /// associated ingestion job id.
    ingested_files_summary: ?IngestedFilesSummary = null,

    /// Specifies the S3 location configuration for the data input for the data
    /// ingestion job.
    ingestion_input_configuration: ?IngestionInputConfiguration = null,

    /// Specifies the time the dataset was last updated, if it was.
    last_updated_at: ?i64 = null,

    /// The Amazon Resource Name (ARN) of the IAM role that you are using for this
    /// the data
    /// ingestion job.
    role_arn: ?[]const u8 = null,

    /// A JSON description of the data that is in each time series dataset,
    /// including names,
    /// column names, and data types.
    schema: ?[]const u8 = null,

    /// Provides the identifier of the KMS key used to encrypt dataset data by
    /// Amazon Lookout
    /// for Equipment.
    server_side_kms_key_id: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the source dataset from which the current
    /// data being
    /// described was imported from.
    source_dataset_arn: ?[]const u8 = null,

    /// Indicates the status of the dataset.
    status: ?DatasetStatus = null,

    pub const json_field_names = .{
        .created_at = "CreatedAt",
        .data_end_time = "DataEndTime",
        .data_quality_summary = "DataQualitySummary",
        .dataset_arn = "DatasetArn",
        .dataset_name = "DatasetName",
        .data_start_time = "DataStartTime",
        .ingested_files_summary = "IngestedFilesSummary",
        .ingestion_input_configuration = "IngestionInputConfiguration",
        .last_updated_at = "LastUpdatedAt",
        .role_arn = "RoleArn",
        .schema = "Schema",
        .server_side_kms_key_id = "ServerSideKmsKeyId",
        .source_dataset_arn = "SourceDatasetArn",
        .status = "Status",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeDatasetInput, options: Options) !DescribeDatasetOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "lookoutequipment");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeDatasetInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("lookoutequipment", "LookoutEquipment", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "AWSLookoutEquipmentFrontendService.DescribeDataset");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeDatasetOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeDatasetOutput, body, allocator);
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "AccessDeniedException")) {
        return .{ .arena = arena, .kind = .{ .access_denied_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServerException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceQuotaExceededException")) {
        return .{ .arena = arena, .kind = .{ .service_quota_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ThrottlingException")) {
        return .{ .arena = arena, .kind = .{ .throttling_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ValidationException")) {
        return .{ .arena = arena, .kind = .{ .validation_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
